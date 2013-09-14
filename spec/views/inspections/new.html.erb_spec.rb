require 'spec_helper'

describe "inspections/new" do
  before(:each) do
    assign(:inspection, stub_model(Inspection,
      :inspection_type => "MyString",
      :unit => "MyString",
      :tenant => "MyString",
      :inspected_by => "MyString"
    ).as_new_record)
  end

  it "renders new inspection form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inspections_path, "post" do
      assert_select "input#inspection_inspection_type[name=?]", "inspection[inspection_type]"
      assert_select "input#inspection_unit[name=?]", "inspection[unit]"
      assert_select "input#inspection_tenant[name=?]", "inspection[tenant]"
      assert_select "input#inspection_inspected_by[name=?]", "inspection[inspected_by]"
    end
  end
end
