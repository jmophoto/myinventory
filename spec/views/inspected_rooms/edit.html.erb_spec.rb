require 'spec_helper'

describe "inspected_rooms/edit" do
  before(:each) do
    @inspected_room = assign(:inspected_room, stub_model(InspectedRoom))
  end

  it "renders the edit inspected_room form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inspected_room_path(@inspected_room), "post" do
    end
  end
end
