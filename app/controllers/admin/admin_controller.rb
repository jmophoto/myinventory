class Admin::AdminController < ApplicationController

  before_filter :require_admin_user

  def require_admin_user
    redirect_to(root_path) if !current_user || !current_user.admin?
  end

end
