require 'spec_helper'

describe "User Pages" do
  
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "Register" }
    it { should have_title('Sign Up') }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "First name", with: "Example"
        fill_in "Last name", with: "User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect{ click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: "user@example.com") }
        
        it { should have_link('Sign Out') }
      end
    end
        
  end
end
