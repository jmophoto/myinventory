class CustomersController < ApplicationController
  before_action :set_user
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def show
  end
  
  # GET /customers/new
  def new
    @customer = @user.customer
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  def create
    @customer = BraintreeRails::Customer.new(customer_params)

    if @customer.save
      @user.update_attributes(customer_id: @customer.id)
      credit_card = @customer.credit_cards[0]
      @user.payment_methods.create!(token:  credit_card.token, last_four: credit_card.last_4, expiration_date: Date.new(cc.expiration_year.to_i, cc.expiration_month.to_i, -1), cardholder_name: credit_card.cardholder_name) unless credit_card.nil?
      redirect_to account_path and return
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update_attributes(customer_params)
      @customer.credit_cards.each do |cc|
        pm = @user.payment_methods.find_or_create_by(token: cc.token)
        pm.update_attributes(last_four: cc.last_4, expiration_date: Date.new(cc.expiration_year.to_i, cc.expiration_month.to_i, -1), token: cc.token, cardholder_name: cc.cardholder_name)
      end
      redirect_to account_path and return
    else
      render action: 'edit'
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy
    @user.update_attribute(:customer_id, nil)
    redirect_to user_path(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end
    
    def set_customer
      @customer = @user.customer
    end

    # Only allow a trusted parameter "white list" through.
    def customer_params
      params[:customer]
    end
end
