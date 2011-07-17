require 'spec_helper'

describe Tweet do

  describe "class method #create_or_update" do
    before :each do
      attribs = test_tweet_attribs

      @identifier           = attribs[:identifier]
      @text                 = attribs[:text]
      @created_at           = attribs[:created_at]
      @from_user_identifier = attribs[:from_user_identifier]
      @from_user            = attribs[:from_user]
      @profile_image_url    = attribs[:profile_image_url]
      @source               = attribs[:source]
      @geo                  = attribs[:geo]
      @provider_name        = attribs[:provider_name]
      @oembed_type          = attribs[:oembed_type]
      @url                  = attribs[:url]
    end

    it "should create 1 Tweeter and 1 Tweet" do
      Tweet.count.should == 0
      Tweeter.count.should == 0

      def create_or_update_one
        Tweet.create_or_update(@identifier,
                               @text,
                               @created_at,
                               @from_user_identifier,
                               @from_user,
                               @profile_image_url,
                               @source,
                               @geo,
                               @provider_name,
                               @oembed_type,
                               @url
                               )
      end
      t_init = create_or_update_one
      t_init.should be_instance_of Tweet

      Tweeter.count.should == 1
      Tweet.count.should == 1

      u = Tweeter.first
      u.identifier.should        == @from_user_identifier
      u.username.should          == @from_user
      u.profile_image_url.should == @profile_image_url

      t = Tweet.first
      t.tweeter.should          == u
      t.identifier.should       == @identifier
      t.tweet_text.should       == @text
      t.tweet_created_at.should == @created_at
      t.source.should           == @source
      t.geo.should              == @geo
      t.provider_name.should    == @provider_name
      t.oembed_type.should      == @oembed_type
      t.url.should              == @url

      # updating the same one should cause no changes in Tweeter or Tweet count
      create_or_update_one
      Tweeter.count.should == 1
      Tweet.count.should == 1

      # another tweet from the same user should increment Tweet count by 1
      Tweet.create_or_update(89970252775043072,
                             "Sekaa gong #bali #culture http://instagr.am/p/HWQgq/",
                             Time.parse("Sun, 10 Jul 2011 08:12:34 +0000"),
                             @from_user_identifier,
                             @from_user,
                             @profile_image_url,
                             "&lt;a href=&quot;http://instagr.am&quot; rel=&quot;nofollow&quot;&gt;instagram&lt;/a&gt;",
                             nil,
                             @provider_name,
                             @oembed_type,
                             @url)
      Tweeter.count.should == 1
      Tweet.count.should   == 2

      # 2nd tweet's user should still be the first one
      Tweet.last.tweeter.should == u
    end
  end
end
