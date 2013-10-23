require 'spec_helper'

describe "inspection_details/new" do
  before(:each) do
    assign(:inspection_detail, stub_model(InspectionDetail).as_new_record)
  end

  it "renders new inspection_detail form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inspection_details_path, "post" do
    end
  end
end
