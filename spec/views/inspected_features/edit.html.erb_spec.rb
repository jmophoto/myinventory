require 'spec_helper'

describe "inspected_features/edit" do
  before(:each) do
    @inspected_feature = assign(:inspected_feature, stub_model(InspectedFeature))
  end

  it "renders the edit inspected_feature form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inspected_feature_path(@inspected_feature), "post" do
    end
  end
end
