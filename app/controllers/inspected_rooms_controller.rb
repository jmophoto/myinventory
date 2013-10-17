class InspectedRoomsController < ApplicationController
  before_action :set_inspected_room, only: [:show, :edit, :update, :destroy]

  # GET /inspected_rooms
  def index
    inspection = Inspection.find(params[:inspection_id])
    @inspected_rooms = inspection.inspected_rooms.load
    respond_to do |format|
      format.html
      format.json { render :json => @inspected_rooms }
    end
  end

  # GET /inspected_rooms/1
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @inspected_room.to_json(:include => :inspected_features) }
    end
  end

  # GET /inspected_rooms/new
  def new
    @inspected_room = InspectedRoom.new
  end

  # GET /inspected_rooms/1/edit
  def edit
  end

  # POST /inspected_rooms
  def create
    @inspected_room = InspectedRoom.new(inspected_room_params)

    if @inspected_room.save
      respond_to do |format|
        format.html { redirect_to @inspected_room, notice: 'Inspected room was successfully created.' }
        format.json { render :json => @inspected_room.to_json(:include => :inspected_features) }
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /inspected_rooms/1
  def update
    if @inspected_room.update(inspected_room_params)
      respond_to do |format|
        format.html { redirect_to @inspected_room, notice: 'Inspected room was successfully updated.' }
        format.json { head :no_content }
      end
    else
      render action: 'edit'
    end
  end

  # DELETE /inspected_rooms/1
  def destroy
    @inspected_room.destroy
    respond_to do |format|
      format.html { redirect_to inspected_rooms_url, notice: 'Inspected room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspected_room
      @inspected_room = InspectedRoom.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def inspected_room_params
      params.require(:inspected_room).permit!
    end
end
