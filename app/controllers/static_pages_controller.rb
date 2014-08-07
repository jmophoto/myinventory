class StaticPagesController < ApplicationController
  before_action :agent_user?, only: [:agent]
  before_action :admin_user?, only: [:admin]
  
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
  
  def faq
  end
  
  def user_faq
  end
  
  def servivces
  end
  
  def toc
  end
  
  def agent
  end
  
  def admin
  end
end
