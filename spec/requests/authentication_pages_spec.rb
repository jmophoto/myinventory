require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "Sign In" }
      it { should have_title('Sign In') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error', text: 'Invalid') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password 
        click_button "Sign In"
      end 
      
      it { should have_link('Profile') }
      it { should have_link('Sign Out', href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign Out" }
        it {should have_link("Sign In") }
      end
      
      describe "followed by signout" do
        before { click_link "Sign Out" }
        it { should have_link("Sign In") }
      end
      
    end
      
    describe "authorization" do
      
      describe "for non-signed-in users" do
        let(:user) { FactoryGirl.create(:user) }
        
        describe "when attempting to visit a protected page" do
          before do
            visit profile_path
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Sign In"
          end
          
          describe "after signing in" do
            it "should render the desired protected page" do
              expect(page).to have_title('Profile')
            end
            
          end
             
        end
        
        describe "in the Users controller" do
          
          describe "visting to edit page" do
            before { visit edit_user_path(user) }
            it { should have_title("Sign In") }
          end
          
          describe "submitting to the update action" do
            before { patch user_path(user) }
            specify { expect(response).to redirect_to(signin_path) }
          end
        end
        
        describe "in the Properties controller" do
          
          describe "submitting to the create action" do
            before { post properties_path }
            specify { expect(response).to redirect_to(signin_path) }
          end
          
          describe "submitting to the destroy action" do
            before { delete property_path(FactoryGirl.create(:property)) }
            specify{ expect(response).to redirect_to(signin_path) }
          end
          
        end
      
      end
      
    end
    
  end

end
