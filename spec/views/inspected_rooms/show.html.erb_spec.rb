require 'spec_helper'

describe "inspected_rooms/show" do
  before(:each) do
    @inspected_room = assign(:inspected_room, stub_model(InspectedRoom))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
