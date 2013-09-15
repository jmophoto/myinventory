require "spec_helper"

describe InspectedFeaturesController do
  describe "routing" do

    it "routes to #index" do
      get("/inspected_features").should route_to("inspected_features#index")
    end

    it "routes to #new" do
      get("/inspected_features/new").should route_to("inspected_features#new")
    end

    it "routes to #show" do
      get("/inspected_features/1").should route_to("inspected_features#show", :id => "1")
    end

    it "routes to #edit" do
      get("/inspected_features/1/edit").should route_to("inspected_features#edit", :id => "1")
    end

    it "routes to #create" do
      post("/inspected_features").should route_to("inspected_features#create")
    end

    it "routes to #update" do
      put("/inspected_features/1").should route_to("inspected_features#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/inspected_features/1").should route_to("inspected_features#destroy", :id => "1")
    end

  end
end
