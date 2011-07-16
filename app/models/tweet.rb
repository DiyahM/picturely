# == Schema Information
# Schema version: 20110715101503
#
# Table name: tweets
#
#  id               :integer(4)      not null, primary key
#  tweeter_id       :integer(4)      not null
#  identifier       :integer(8)      not null
#  tweet_text       :string(255)
#  tweet_created_at :datetime
#  source           :string(255)
#  geo              :string(255)
#  provider_name    :string(255)
#  oembed_type      :string(255)
#  url              :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_tweets_on_tweeter_id  (tweeter_id)
#  index_tweets_on_identifier  (identifier)
#

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
