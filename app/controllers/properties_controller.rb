class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
  wrap_parameters include: [:name, :details, :desscription, :room_count, :other_areas, :address_attributes]

  # GET /properties
  def index
    @properties = current_user.properties
    respond_to do |format|
      format.html
      format.json { render json: @properties, root: false }
    end
  end

  # GET /properties/1
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @property, root: false }
    end
  end

  # GET /properties/new
  def new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  def create
    @property = current_user.properties.build(property_params)
    if @property.save
      @property.process_rooms(params[:property][:room_count])
      @property.process_other_areas(params[:property][:other_areas])
      render json: @property, root: false
      # redirect_to edit_property_path(@property), notice: 'Property was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /properties/1
  def update
    if @property.update(property_params)
      render json: @property, root: false
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
