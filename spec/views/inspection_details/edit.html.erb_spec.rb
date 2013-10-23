require 'spec_helper'

describe "inspection_details/edit" do
  before(:each) do
    @inspection_detail = assign(:inspection_detail, stub_model(InspectionDetail))
  end

  it "renders the edit inspection_detail form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inspection_detail_path(@inspection_detail), "post" do
    end
  end
end
