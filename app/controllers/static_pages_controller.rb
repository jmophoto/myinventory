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
  end
  
  def properties
  end
  
  def support
  end
end
