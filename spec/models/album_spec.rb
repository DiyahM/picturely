require 'spec_helper'

describe Album do
  before (:each) do
     @attr = {
       :name => "Example User", 
       :email => "user@example.com",
       :password =>"foobar",
       :password_confirmation =>"foobar"
       }
      @user = User.create!(@attr) 
   end
 
  
  it "should belong to a user" do
   album = Album.new(:user_id => @user)
   album.user_id.should == 1
  end
end
