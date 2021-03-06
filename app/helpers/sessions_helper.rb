module SessionsHelper
  
  def admin_user?
    unless signed_in? && current_user.admin?
      store_location
      flash[:error] = "This page is for adminstrators only."
      redirect_to signin_url
    end
  end
  
  def agent_user?
    unless signed_in? && current_user.agent?
      store_location
      flash[:error] = "This page is for agents only."
      redirect_to signin_url
    end
  end
  
  def approved_agent?
    unless signed_in? && current_user.approved_agent?
      store_location
      flash[:error] = "This page is for agents only."
      redirect_to signin_url
    end
  end
  
  
  
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token) 
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.url
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      flash[:error] = "Please sign in."
      redirect_to signin_url
    end
  end 
  
end
