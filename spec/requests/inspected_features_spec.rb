require 'spec_helper'

describe "InspectedFeatures" do
  describe "GET /inspected_features" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get inspected_features_path
      response.status.should be(200)
    end
  end
end
