class StaticPagesController < ApplicationController
  def home
    render :layout => 'homepage'
  end

  def about
  end
  
  def signup
  end
  
  def contact
    @message = Message.new
  end
  
  def profile
  end
  
  def properties
  end
  
  def support
  end
end
