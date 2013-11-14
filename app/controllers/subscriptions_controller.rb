class SubscriptionsController < ApplicationController
  before_action :set_user
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  # GET /subscriptions
  def index
  end

  # GET /subscriptions/1
  def show
    @customer = @user.customer
  end

  # GET /subscriptions/new
  def new
    @subscription = BraintreeRails::Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  def create
    @subscription = BraintreeRails::Subscription.new(subscription_params)

    if @subscription.save
      @user.create_subscription(subscription_id: @subscription.id, end_date: Date.parse(@subscription.paid_through_date), plan_id: @subscription.plan_id)
      redirect_to profile_path, notice: 'Subscription was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /subscriptions/1
  def update
    if @subscription.update(subscription_params)
      redirect_to @subscription, notice: 'Subscription was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /subscriptions/1
  def destroy
    @subscription.destroy
    redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end
    
    def set_subscription
      @subscription = @user.subscription
    end
    # Only allow a trusted parameter "white list" through.
    def subscription_params
      params[:subscription]
    end
end
