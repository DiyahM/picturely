require 'spec_helper'

describe Tweet do

  describe "class method #create_or_update" do
    before :each do
      @identifier = 89975912136835073
      @text = "Krisna #bali #iphoneography #iphonesia #iphonesian   @ Krisna Oleh-Oleh Khas Bali http://instagr.am/p/HWT-R/"
      @created_at = Time.parse "Sun, 10 Jul 2011 08:35:03 +0000"
      @from_user_identifier = 9399124
      @from_user = "karinarizal"
      @profile_image_url = "http://a3.twimg.com/profile_images/1423609813/mqcnE_normal.jpg"
      @source = "&lt;a href=&quot;http://instagr.am&quot; rel=&quot;nofollow&quot;&gt;instagram&lt;/a&gt;"
      @geo = "point(-4.1234, 101.3546)"
      @provider_name = "Instagram"
      @oembed_type = "photo"
      @url = "http://images.instagram.com/media/2011/07/10/ec3ca2718934472597b377fe10c5394b_7.jpg"
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
