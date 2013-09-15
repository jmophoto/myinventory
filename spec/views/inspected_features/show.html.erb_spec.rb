require 'spec_helper'

describe "inspected_features/show" do
  before(:each) do
    @inspected_feature = assign(:inspected_feature, stub_model(InspectedFeature))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
