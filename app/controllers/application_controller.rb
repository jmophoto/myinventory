class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper 

  # force_ssl if: :force_ssl?
  # 
  # def force_ssl?
  #   !Rails.env.development?
  # end
  
end
