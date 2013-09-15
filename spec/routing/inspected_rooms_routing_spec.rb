require "spec_helper"

describe InspectedRoomsController do
  describe "routing" do

    it "routes to #index" do
      get("/inspected_rooms").should route_to("inspected_rooms#index")
    end

    it "routes to #new" do
      get("/inspected_rooms/new").should route_to("inspected_rooms#new")
    end

    it "routes to #show" do
      get("/inspected_rooms/1").should route_to("inspected_rooms#show", :id => "1")
    end

    it "routes to #edit" do
      get("/inspected_rooms/1/edit").should route_to("inspected_rooms#edit", :id => "1")
    end

    it "routes to #create" do
      post("/inspected_rooms").should route_to("inspected_rooms#create")
    end

    it "routes to #update" do
      put("/inspected_rooms/1").should route_to("inspected_rooms#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/inspected_rooms/1").should route_to("inspected_rooms#destroy", :id => "1")
    end

  end
end
