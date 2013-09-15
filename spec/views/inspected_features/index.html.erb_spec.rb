require 'spec_helper'

describe "inspected_features/index" do
  before(:each) do
    assign(:inspected_features, [
      stub_model(InspectedFeature),
      stub_model(InspectedFeature)
    ])
  end

  it "renders a list of inspected_features" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
