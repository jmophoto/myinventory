class InspectedRoomsController < ApplicationController
  respond_to :json
  
  def index
    inspection = Inspection.find(params[:inspection_id])
    respond_with inspection.inspected_rooms.all
  end

  def show
    respond_with InspectedRoom.find(params[:id])
  end

  def create
    respond_with InspectedRoom.create(params[:entry])
  end

  def update
    respond_with InspectedRoom.update(params[:id], params[:entry])
  end

  def destroy
    respond_with InspectedRoom.destroy(params[:id])
  end
end
