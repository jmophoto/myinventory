class InspectedFeaturesController < ApplicationController
  respond_to :json
  
  def index
    room = InspectedRoom.find(params[:inspected_room_id])
    respond_with room.inspected_features
  end

  def show
    respond_with InspectedFeature.find(params[:id])
  end

  def create
    respond_with InspectedFeature.create(params[:entry])
  end

  def update
    respond_with InspectedFeature.update(params[:id], params[:entry])
  end

  def destroy
    respond_with InspectedFeature.destroy(params[:id])
  end
  
end
