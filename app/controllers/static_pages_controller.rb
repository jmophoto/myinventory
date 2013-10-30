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
    render :layout => 'contact'
  end
  
  def profile
  end
  
  def properties
  end
end
