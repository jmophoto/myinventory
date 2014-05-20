require 'spec_helper'

describe "valuables/edit" do
  before(:each) do
    @valuable = assign(:valuable, stub_model(Valuable))
  end

  it "renders the edit valuable form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", valuable_path(@valuable), "post" do
    end
  end
end
