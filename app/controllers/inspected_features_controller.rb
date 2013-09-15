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
    respond_with InspectedFeature.create(inspected_feature_params)
  end

  def update
    respond_with InspectedFeature.update(params[:id], inspected_feature_params)
  end

  def destroy
    respond_with InspectedFeature.destroy(params[:id])
  end
  
  private

  def inspected_feature_params
    params.require(:inspected_feature).permit!
  end
  
end
