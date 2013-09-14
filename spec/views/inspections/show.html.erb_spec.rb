require 'spec_helper'

describe "inspections/show" do
  before(:each) do
    @inspection = assign(:inspection, stub_model(Inspection,
      :inspection_type => "Inspection Type",
      :unit => "Unit",
      :tenant => "Tenant",
      :inspected_by => "Inspected By"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Inspection Type/)
    rendered.should match(/Unit/)
    rendered.should match(/Tenant/)
    rendered.should match(/Inspected By/)
  end
end
