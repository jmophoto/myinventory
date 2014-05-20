require 'spec_helper'

describe "Valuables" do
  describe "GET /valuables" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get valuables_path
      response.status.should be(200)
    end
  end
end
