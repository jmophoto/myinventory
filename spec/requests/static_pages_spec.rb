require 'spec_helper'

describe "StaticPages" do
  
  describe "Home Page" do
    it "should have the right title" do
      visit '/home'
      expect(page).to have_title("Home")
    end
  end
  
  describe "About Page" do
    it "should have the right title" do
      visit '/about'
      expect(page).to have_title("About")
    end
  end
  
  describe "Signup Page" do
    it "should have the right title" do
      visit '/signup'
      expect(page).to have_title("Sign Up")
    end
  end
  
  describe "About Page" do
    it "should have the right title" do
      visit '/contact'
      expect(page).to have_title("Contact")
    end
  end
  
end
