require 'spec_helper'

describe "valuables/show" do
  before(:each) do
    @valuable = assign(:valuable, stub_model(Valuable))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
