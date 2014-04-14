class AuthorizeNetController < ApplicationController
  before_action :set_user
  
  def submit_transaction
    transaction = AuthorizeNet::AIM::Transaction.new('7uNy39X7', '5WLu92n9U8H6z34s', gateway: :sandbox)
    credit_card = AuthorizeNet::CreditCard.new('4111111111111111', '1120')
    response = transaction.purchase('10.00', credit_card)

    if response.success?
      puts "Successfully made a purchase (authorization code: #{response.authorization_code})"
    else
      raise "Failed to make purchase."
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end
end