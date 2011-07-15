class Tweet < ActiveRecord::Base
  belongs_to :tweeter

  def self.create_or_update(identifier, text, created_at,
                            from_user_identifier, from_user,
                            profile_img, source, geo,
                            provider_name, oembed_type, url)
    u = Tweeter.find_or_create_by_identifier(from_user_identifier,
                                             :username => from_user,
                                             :profile_image_url => profile_img)

    Tweet.find_or_create_by_identifier(identifier,
                                       :tweeter_id => u.id,
                                       :tweet_text => text,
                                       :tweet_created_at => created_at,
                                       :source => source,
                                       :geo => geo,
                                       :provider_name => provider_name,
                                       :oembed_type => oembed_type,
                                       :url => url
                                       )
  end

end
