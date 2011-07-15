require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign in")
    end
  end
  
  describe "Post 'create'" do
    describe "invalid signin" do
      before(:each) do
        @attr = {:email => "email@example.com", :password => "invalid"}
      end
      
      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end
      
      it "should have the right title" do
        post :create, :session=> @attr
        response.should have_selector("title", :content => "Sign in")
      end
    end
    
    describe "with valid email and password" do
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end
      
      it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end
      
      it "should redeirect to the album index page" do
        post :create, :session => @attr
        response.should redirect_to('/albums')
      end
    end

  end

end
