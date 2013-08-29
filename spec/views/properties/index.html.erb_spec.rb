require 'spec_helper'

describe "properties/index" do
  before(:each) do
    assign(:properties, [
      stub_model(Property,
        :address => "Address",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :user => nil
      ),
      stub_model(Property,
        :address => "Address",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :user => nil
      )
    ])
  end

  it "renders a list of properties" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
