class PaymentMethod < ActiveRecord::Base
  belongs_to :user
  
  before_destroy :delete_from_braintree
  
  def delete_from_braintree
    begin
      pm = BraintreeRails::CreditCard.find(token)
      pm.destroy
    rescue
    end
  end
end
