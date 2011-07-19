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

    @album = @user.albums.create!
   end
 
  
  it "should belong to a user" do
   @album.user_id.should == @user.id
  end

  describe "#add_tweet" do
    before :each do
      @tweet_identifier = 111_222_333_444
      @tweet_text       = "hello world"
      @from_user_identifier = 555_666_777_888
    end

    it "should create new Tweet and SearchResult" do
      lambda {
        @album.add_tweet @tweet_identifier, @tweet_text, @from_user_identifier
      }.should change(Tweet, :count).by(1)
    end
  end

end
