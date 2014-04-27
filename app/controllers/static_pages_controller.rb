class StaticPagesController < ApplicationController
  def home
    render :layout => 'homepage'
  end

  def about
    render :layout => 'static_page'
  end
  
  def signup
  end
  
  def contact
    render :layout => 'static_page'
    @message = Message.new
  end
  
  def profile
    @amount = 10.00
    @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :relay_url => payments_relay_response_url(:only_path => false))
  end
  end
  
  def properties
  end
  
  def support
  end
  
  def toc
  end
end
