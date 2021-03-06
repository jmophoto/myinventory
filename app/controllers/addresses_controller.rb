class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  # GET /addresses
  def index
    @addresses = Address.all
    respond_to do |format|
      format.html
      format.json { render json: @addresses, root: false }
    end
  end

  # GET /addresses/1
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @addresses, root: false }
    end
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)

    if @address.save
      redirect_to @address, notice: 'Address was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /addresses/1
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
    redirect_to addresses_url, notice: 'Address was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def address_params
      params.require(:address).permit!
    end
end
