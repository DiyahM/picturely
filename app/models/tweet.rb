class Tweet < ActiveRecord::Base
  belongs_to :tweeter

  def self.create_or_update(identifier, text, created_at,
                            from_user_identifier, from_user,
                            profile_img, source, geo,
                            provider_name, oembed_type, url)
    u = Tweeter.find_or_create_by_identifier(from_user_identifier,
                                             :username => from_user,
                                             :profile_image_url => profile_img)

    t = u.tweets.find_or_create_by_identifier(identifier)
    t.tweet_text = text
    t.tweet_created_at = created_at
    t.source = source
    t.geo = geo
    t.provider_name = provider_name
    t.oembed_type = oembed_type
    t.url = url
    t.save!
  end

end
