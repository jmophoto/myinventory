require 'spec_helper'

describe "inspected_rooms/new" do
  before(:each) do
    assign(:inspected_room, stub_model(InspectedRoom).as_new_record)
  end

  it "renders new inspected_room form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inspected_rooms_path, "post" do
    end
  end
end
