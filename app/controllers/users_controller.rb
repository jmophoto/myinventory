class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :signed_in_user, except: [:new, :create]
  # before_action :correct_user, only: [:edit, :update]
  
  def show
    render json: @user, root: false
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Thank you for registering!"
      redirect_to profile_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      sign_in @user
      render json: @user, root: false
    else
      render 'edit'
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit!
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user(@user)
    end
  
end
