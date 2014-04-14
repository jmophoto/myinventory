class Admin::UsersController < Admin::AdminController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user), notice: 'User Updated'
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end

end
