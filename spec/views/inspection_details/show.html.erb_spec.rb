require 'spec_helper'

describe "inspection_details/show" do
  before(:each) do
    @inspection_detail = assign(:inspection_detail, stub_model(InspectionDetail))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
