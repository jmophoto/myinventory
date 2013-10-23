require 'spec_helper'

describe "inspection_details/index" do
  before(:each) do
    assign(:inspection_details, [
      stub_model(InspectionDetail),
      stub_model(InspectionDetail)
    ])
  end

  it "renders a list of inspection_details" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
