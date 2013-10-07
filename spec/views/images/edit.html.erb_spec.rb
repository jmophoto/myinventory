require 'spec_helper'

describe "images/edit" do
  before(:each) do
    @image = assign(:image, stub_model(Image,
      :inspection => nil,
      :user => nil
    ))
  end

  it "renders the edit image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", image_path(@image), "post" do
      assert_select "input#image_inspection[name=?]", "image[inspection]"
      assert_select "input#image_user[name=?]", "image[user]"
    end
  end
end
