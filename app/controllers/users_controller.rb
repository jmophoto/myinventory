class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :signed_in_user, except: [:new, :create, :new_agent]
  before_action :admin_user?, only: [:index,:agent_index]
  wrap_parameters include: [:agent, :agent_status, :admin, :first_name, :last_name, :email, :password, :password_confirmation]
  
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users, root: false }
    end
  end
  
  def agent_index
    if params[:status]
      @users = User.by_agent_status(params[:status])
    else
      @users = User.active_agents
    end
    respond_to do |format|
      format.html
      format.json { render json: @users, root: false }
    end
  end
    
  def show
    respond_to do |format|
      format.html
      format.json { render json: @user, root: false }
    end
  end
  
  def new
    @user = User.new
    @user.build_address
  end
  
  def new_agent
    @user = User.new
    @user.build_address
  end
  
  
  def create
    @user = User.new(user_params)
    if params[:agent_request].present?
      @user.agent = true
      @user.agent_status = 'pending'
    end
    if @user.save
      @user.create_address
      sign_in(@user)
      if @user.agent?
        redirect_to(agent_inspections_path)
      else
        redirect_to profile_path
      end
    else
      render 'new'
    end
  end
  
  def edit
    @user = current_user
    @transaction = BraintreeRails::Transaction.new
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
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
