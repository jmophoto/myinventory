class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user

  # GET /properties
  def index
    @properties = Property.all
  end

  # GET /properties/1
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  def create
    @property = current_user.properties.build(property_params)
    if @property.save
      @property.process_rooms(params[:property][:room_count])
      redirect_to @property, notice: 'Property was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /properties/1
  def update
    if @property.update(property_params)
      @property.check_rooms(params[:property][:room_count])
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /properties/1
  def destroy
    @property.destroy
    redirect_to properties_url, notice: 'Property was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def property_params
      params.require(:property).permit!
    end
end
