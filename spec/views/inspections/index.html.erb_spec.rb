require 'spec_helper'

describe "inspections/index" do
  before(:each) do
    assign(:inspections, [
      stub_model(Inspection,
        :inspection_type => "Inspection Type",
        :unit => "Unit",
        :tenant => "Tenant",
        :inspected_by => "Inspected By"
      ),
      stub_model(Inspection,
        :inspection_type => "Inspection Type",
        :unit => "Unit",
        :tenant => "Tenant",
        :inspected_by => "Inspected By"
      )
    ])
  end

  it "renders a list of inspections" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Inspection Type".to_s, :count => 2
    assert_select "tr>td", :text => "Unit".to_s, :count => 2
    assert_select "tr>td", :text => "Tenant".to_s, :count => 2
    assert_select "tr>td", :text => "Inspected By".to_s, :count => 2
  end
end
