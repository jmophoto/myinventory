# encoding: utf-8
# require 'mcrypt'

class OldUser < ActiveRecord::Base
  # CLIENT = Mcrypt::Rijndael256.new
  KEY    = "inspeckd"

  # establish_connection(
  #   adapter:  "mysql2",
  #   host:     "localhost",
  #   username: "root",
  #   password: "",
  #   database: "old_inspeckd"
  # )
  # 
  # self.table_name  = "tbl_user_master"
  # self.primary_key = "user_id"
  # 
  # def import
  #   User.create!(
  #     first_name: self.user_name_first, 
  #     last_name: self.user_name_last, 
  #     email: self.user_email,
  #     legacy_id: self.user_id,
  #     password: "password",
  #     password_confirmation: "password"
  #   )
  # end

  # def decrypted_password
  #   @decrypted_password ||= user_password.blank? ? nil : CLIENT.decrypt(KEY, user_password)
  # end
end
