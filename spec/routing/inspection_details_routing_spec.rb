require "spec_helper"

describe InspectionDetailsController do
  describe "routing" do

    it "routes to #index" do
      get("/inspection_details").should route_to("inspection_details#index")
    end

    it "routes to #new" do
      get("/inspection_details/new").should route_to("inspection_details#new")
    end

    it "routes to #show" do
      get("/inspection_details/1").should route_to("inspection_details#show", :id => "1")
    end

    it "routes to #edit" do
      get("/inspection_details/1/edit").should route_to("inspection_details#edit", :id => "1")
    end

    it "routes to #create" do
      post("/inspection_details").should route_to("inspection_details#create")
    end

    it "routes to #update" do
      put("/inspection_details/1").should route_to("inspection_details#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/inspection_details/1").should route_to("inspection_details#destroy", :id => "1")
    end

  end
end
