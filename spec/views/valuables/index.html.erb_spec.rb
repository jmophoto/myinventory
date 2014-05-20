require 'spec_helper'

describe "valuables/index" do
  before(:each) do
    assign(:valuables, [
      stub_model(Valuable),
      stub_model(Valuable)
    ])
  end

  it "renders a list of valuables" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
