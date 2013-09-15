require 'spec_helper'

describe "InspectedRooms" do
  describe "GET /inspected_rooms" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get inspected_rooms_path
      response.status.should be(200)
    end
  end
end
