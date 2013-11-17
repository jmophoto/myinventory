class Subscription < ActiveRecord::Base
  belongs_to :user
  has_one :payment_method, primary_key: :payment_method_token, foreign_key: :token
end
