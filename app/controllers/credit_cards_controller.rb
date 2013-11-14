class CreditCardsController < ApplicationController
  before_action :set_user
  before_action :set_customer
  before_action :set_credit_card, only: [:show, :edit, :update, :destroy]

  # GET /credit_cards
  def index
    @credit_cards = @customer.credit_cards
  end

  # GET /credit_cards/1
  def show
  end

  # GET /credit_cards/new
  def new
    @credit_card = @customer.credit_cards.build
  end

  # GET /credit_cards/1/edit
  def edit
  end

  # POST /credit_cards
  def create
    @credit_card = @customer.credit_cards.build(credit_card_params)

    if @credit_card.save
      @user.payment_methods.create(last_four: @credit_card.last_4, expiration_date: @credit_card.expiration_date, token: @credit_card.token)
      redirect_to user_customer_credit_card_path(@user, @credit_card)
    else
      flash[:alert] = @credit_card.errors.full_messages.join(".\n")
      render :new
    end
  end

  # PATCH/PUT /credit_cards/1
  def update
    if @credit_card.update(credit_card_params)
      redirect_to user_customer_credit_card_path(@user, @credit_card) and return
    else
      render action: 'edit'
    end
  end

  # DELETE /credit_cards/1
  def destroy
    @credit_card.destroy
    redirect_to user_customer_credit_cards_path(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end
    
    def set_customer
      @customer  = @user.customer
      redirect_to user_path(@user) and return if @customer.nil?
    end
    
    def set_credit_card
      @credit_card = @customer.credit_cards.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def credit_card_params
      params[:credit_card]
    end
end
