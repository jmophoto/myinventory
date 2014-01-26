class StaticPagesController < ApplicationController
  def home
    render :layout => 'homepage'
  end

  def about
    render :layout => 'about'
  end
  
  def signup
  end
  
  def contact
    @message = Message.new
    render :layout => 'contact'
  end
  
  def profile
  end
  
  def properties
  end
  
  def support
  end
end
