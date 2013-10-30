class User < ActiveRecord::Base
  
  has_secure_password
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 } if :validate_password?
  
  before_save { email.downcase! }
  before_create :create_remember_token
  
  has_many :properties
  has_many :inspections
  
  belongs_to :account
  
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def validate_password?
    password.present? || password_confirmation.present?
  end
  
  private
    
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
  
end
