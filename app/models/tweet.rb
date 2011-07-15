class Tweet < ActiveRecord::Base
  belongs_to :tweeter

  def self.create_or_update(identifier, text, created_at,
                            from_user_identifier, from_user,
                            profile_image_url, source, geo,
                            provider_name, oembed_type, url)
    user = Tweeter.find_or_create_by_identifier from_user_identifier
    user.username = from_user
    user.profile_image_url = profile_image_url
    user.save!

    t = user.tweets.find_or_create_by_identifier identifier
    t.tweet_text = text
    t.tweet_created_at = created_at
    t.source = source
    t.geo = geo
    t.provider_name = provider_name
    t.url = url
    t.save!
  end

end