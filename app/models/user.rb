class User < ActiveRecord::Base
  
  has_secure_password
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :if => :validate_password?
  
  before_save { email.downcase! }
  before_create :create_remember_token
  # after_create :set_up_new_user
  
  has_many :properties
  has_many :inspections
  has_many :assigned_inspections, class_name: 'Inspection', foreign_key: 'agent_id'
  has_many :payment_methods
  
  belongs_to :account
  has_one :company
  has_one :subscription
  has_one :address, as: :addressable
  
  accepts_nested_attributes_for :account
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :company
  
  def user_type
    if self.admin?
      "Admin"
    elsif self.agent?
      "Agent"
    else
      "User"
    end
  end
  
  def display_agent_status
    if self.agent_status.nil?
      "None"
    else
      self.agent_status.titleize
    end
  end
  
  def self.agent
    where(agent:true)
  end
  
  def self.active_agents
    where(agent:true, agent_status:"approved")
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def validate_password?
    password.present? || password_confirmation.present?
  end
  
  def set_up_new_user
    create_subscription!(start_date: Date.today, end_date: Date.today + 2.weeks, subscription_type: "free")
    create_company!
    create_address!
  end
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def customer
    if customer_id
      begin
        BraintreeRails::Customer.find(customer_id)
      rescue
        BraintreeRails::Customer.new(email: self.email)
      end
    else
      BraintreeRails::Customer.new(email: self.email)
    end
  end
  
  private
    
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
  
end
