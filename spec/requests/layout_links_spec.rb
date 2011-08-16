require 'spec_helper'

describe "LayoutLinks" do
  #describe "GET /layout_links" do
    #it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
     # get layout_links_index_path
      #response.status.should be(200)
    #end
  #end
  
  describe "when not signed in" do
    pending "should have a signin link" do
      visit "albums"
      response.should have_selector("a", :href => signin_path, :content => "Sign in")
    end
  end
  
  describe "when signed in" do
    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email, :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end
    
    pending "should have a signout link" do
      visit "albums"
      response.should have_selector("a", :href => signout_path,
                                      :content => "Sign out")
    end
    
  end
end
