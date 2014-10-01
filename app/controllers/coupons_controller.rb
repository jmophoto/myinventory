class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  # GET /coupons
  def index
    if params[:code]
      @coupons = Coupon.where(code: params[:code])
    else
      @coupons = Coupon.all
    end
    respond_to do |format|
      format.json { render json: @coupons, root: false }
    end
  end

  # GET /coupons/1
  def show
    unless @coupon.nil?
      respond_to do |format|
        format.json { render json: @coupon, root: false }
      end
    end
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      redirect_to @coupon, notice: 'Coupon was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /coupons/1
  def update
    if @coupon.update(coupon_params)
      redirect_to @coupon, notice: 'Coupon was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /coupons/1
  def destroy
    @coupon.destroy
    redirect_to coupons_url, notice: 'Coupon was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.where(code: params[:code]).first
    end

    # Only allow a trusted parameter "white list" through.
    def coupon_params
      params[:coupon]
    end
end
