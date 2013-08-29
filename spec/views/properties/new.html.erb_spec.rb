require 'spec_helper'

describe "properties/new" do
  before(:each) do
    assign(:property, stub_model(Property,
      :address => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :user => nil
    ).as_new_record)
  end

  it "renders new property form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", properties_path, "post" do
      assert_select "input#property_address[name=?]", "property[address]"
      assert_select "input#property_city[name=?]", "property[city]"
      assert_select "input#property_state[name=?]", "property[state]"
      assert_select "input#property_zip[name=?]", "property[zip]"
      assert_select "input#property_user[name=?]", "property[user]"
    end
  end
end
