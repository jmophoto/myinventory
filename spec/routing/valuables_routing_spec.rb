require "spec_helper"

describe ValuablesController do
  describe "routing" do

    it "routes to #index" do
      get("/valuables").should route_to("valuables#index")
    end

    it "routes to #new" do
      get("/valuables/new").should route_to("valuables#new")
    end

    it "routes to #show" do
      get("/valuables/1").should route_to("valuables#show", :id => "1")
    end

    it "routes to #edit" do
      get("/valuables/1/edit").should route_to("valuables#edit", :id => "1")
    end

    it "routes to #create" do
      post("/valuables").should route_to("valuables#create")
    end

    it "routes to #update" do
      put("/valuables/1").should route_to("valuables#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/valuables/1").should route_to("valuables#destroy", :id => "1")
    end

  end
end
