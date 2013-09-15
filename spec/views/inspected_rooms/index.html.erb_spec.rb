require 'spec_helper'

describe "inspected_rooms/index" do
  before(:each) do
    assign(:inspected_rooms, [
      stub_model(InspectedRoom),
      stub_model(InspectedRoom)
    ])
  end

  it "renders a list of inspected_rooms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
