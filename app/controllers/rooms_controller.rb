class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  def index
    property = Property.find(params[:property_id])
    @rooms = property.rooms.load
    respond_to do |format|
      format.html
      format.json { render :json => @rooms }
    end
  end

  # GET /rooms/1
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @room.to_json }
    end
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  def create
    @room = Room.new(room_params)

    if @room.save
      respond_to do |format|
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :json => @room.to_json }
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /rooms/1
  def update
    if @room.update(room_params)
      respond_to do |format|
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
      end
    else
      render action: 'edit'
    end
  end

  # DELETE /rooms/1
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def room_params
      params.require(:room).permit!
    end
end