class AuthorizeNetController < ApplicationController
  before_action :set_user
  
  def submit_transaction
    
  end
  
  def relay_response
    # sim_response = AuthorizeNet::SIM::Response.new(params)
    # if sim_response.success?(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['merchant_hash_value'])
    #   render :text => sim_response.direct_post_reply(payments_receipt_url(:only_path => false), :include => true)
    # else
    #   render
    # end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end
end