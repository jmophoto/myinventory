# encoding: utf-8
require 'ffi'
require 'base64'
require 'digest'

module Mcrypt
  class Rijndael256
    ALGORITHM = "rijndael-256".force_encoding("binary").freeze
    MODE      = "ecb".force_encoding("binary").freeze
    BLOCKSIZE =  256 / 8 # in bytes

    def initialize
      @handle = API.open(ALGORITHM, MODE)
    end

    def encrypt(key, message)
      raise "Can't encrypt w/this module: already closed" if closed?
      begin
        API.prepare(@handle, encoded_key(key), nil, BLOCKSIZE)
        result = API.encrypt(@handle, message, BLOCKSIZE)
      ensure
        API.cleanup(@handle)
      end
      Base64.strict_encode64(result)
    end

    def decrypt(key, message)
      raise "Can't decrypt w/this module: already closed" if closed?
      begin
        API.prepare(@handle, encoded_key(key), nil, BLOCKSIZE)
        message = Base64.strict_decode64(message)
        result  = API.decrypt(@handle, message, BLOCKSIZE)
      ensure
        API.cleanup(@handle)
      end
      result.gsub(/\x00{0,#{BLOCKSIZE - 1}}\z/, "")
    end

    def closed?
      @handle.nil?
    end

    def close!
      unless closed?
        API.close(@handle)
        @handle = nil
      end
    end

    def self.session
      client = new
      begin
        yield client
      ensure
        client.close!
      end
    end

    def self.encrypt(key, message)
      client = new
      begin
        client.encrypt(key, message)
      ensure
        client.close!
      end
    end

    def self.decrypt(key, message)
      client = new
      begin
        client.decrypt(key, message)
      ensure
        client.close!
      end
    end

    private
    def encoded_key(key)
      Digest::SHA256.digest(key)
    end
  end # class Rijndael256

  module API
    extend ::FFI::Library
    ffi_lib "libmcrypt"

    # Type: MCRYPT is a pointer:
    #   struct CRYPT_STREAM;
    #   typedef struct CRYPT_STREAM *MCRYPT;
    typedef :pointer, :mcrypt
    MCRYPT_FAILED = 0
    class McryptError < RuntimeError ; end

    # MCRYPT mcrypt_module_open(char *algorithm, char *algorithm_directory, char *mode, char *mode_directory);
    attach_function :mcrypt_module_open, [:string, :string, :string, :string], :mcrypt
    def self.open(algorithm, mode)
      result = mcrypt_module_open(algorithm, nil, mode, nil)
      if result.to_i == MCRYPT_FAILED
        raise McryptError, "Failed calling mcrypt_module_open(#{algorithm.inspect}, NULL, #{mode.inspect}, NULL)"
      end
      result
    end

    # int mcrypt_generic_init(MCRYPT td, void *key, int lenofkey, void* IV);
    attach_function :mcrypt_generic_init, [:mcrypt, :buffer_in, :int, :buffer_in], :int
    def self.prepare(handle, key, iv, blocksize) # only supports block mode
      raise ArgumentError, "Invalid type for 'key' (expected string): #{key.class.name}" unless key.is_a?(String)
      raise ArgumentError, "Invalid size for 'key' (must be no larger than #{blocksize} bytes): #{key.bytesize}" unless key.bytesize <= blocksize
      raise ArgumentError, "Invalid type for 'iv' (expected string): #{iv.class.name}" unless iv.nil? || iv.is_a?(String)
      raise ArgumentError, "Invalid size for 'iv' (must be no larger than #{blocksize} bytes): #{iv.bytesize}" unless iv.nil? || iv.bytesize <= blocksize
      buffer = FFI::MemoryPointer.new(:char, blocksize, true)
      buffer.put_bytes(0, key)
      if iv
        iv_buffer = FFI::MemoryPointer.new(:char, blocksize, true)
        iv_buffer.put_bytes(0, iv)
      else
        iv_buffer = nil
      end
      result = mcrypt_generic_init(handle, buffer, blocksize, iv)
      if result < 0 # returns negative value on error
        raise McryptError, "Failed calling mcrypt_generic_init(#{handle.inspect}, #{key.inspect}, #{blocksize}, #{iv.inspect}); returned: #{result}"
      end
      result
    end

    # int mcrypt_generic(MCRYPT td, void *plaintext, int len);
    attach_function :mcrypt_generic, [:mcrypt, :buffer_inout, :int], :int
    def self.encrypt(handle, plaintext, blocksize)
      raise ArgumentError, "Invalid type for 'plaintext' (expected string): #{plaintext.class.name}" unless plaintext.is_a?(String)
      length = (plaintext.bytesize / blocksize.to_f).ceil * blocksize
      buffer = FFI::MemoryPointer.new(:char, length, true)
      buffer.put_bytes(0, plaintext)
      unless mcrypt_generic(handle, buffer, length) == 0
        raise McryptError, "Failed calling mcrypt_generic(#{handle.inspect}, #{buffer.inspect}, #{length})"
      end
      buffer.get_bytes(0, length)
    end

    # int mdecrypt_generic(MCRYPT td, void *ciphertext, int len);
    attach_function :mdecrypt_generic, [:mcrypt, :buffer_inout, :int], :int
    def self.decrypt(handle, ciphertext, blocksize)
      raise ArgumentError, "Invalid type for 'ciphertext' (expected string): #{ciphertext.class.name}" unless ciphertext.is_a?(String)
      length = (ciphertext.bytesize / blocksize.to_f).ceil * blocksize
      buffer = FFI::MemoryPointer.new(:char, length, true)
      buffer.put_bytes(0, ciphertext)
      unless mdecrypt_generic(handle, buffer, length) == 0
        raise McryptError, "Failed calling mdecrypt_generic(#{handle.inspect}, #{buffer.inspect}, #{length})"
      end
      buffer.get_bytes(0, length)
    end

    # int mcrypt_generic_deinit(MCRYPT td);
    attach_function :mcrypt_generic_deinit, [:mcrypt], :int
    def self.cleanup(handle)
      result = mcrypt_generic_deinit(handle)
      if result < 0 # negative value on error
        raise McryptError, "Failed calling mcrypt_generic_deinit(#{handle.inspect}); returned: #{result}"
      end
      result
    end

    # int mcrypt_module_close(MCRYPT td);
    attach_function :mcrypt_module_close, [:mcrypt], :int
    def self.close(handle)
      # no docs on the meaning of the return value
      mcrypt_module_close(handle)
    end
  end # module API
end   # module Mcrypt
