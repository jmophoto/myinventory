require 'spec_helper'

describe "images/new" do
  before(:each) do
    assign(:image, stub_model(Image,
      :inspection => nil,
      :user => nil
    ).as_new_record)
  end

  it "renders new image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", images_path, "post" do
      assert_select "input#image_inspection[name=?]", "image[inspection]"
      assert_select "input#image_user[name=?]", "image[user]"
    end
  end
end
