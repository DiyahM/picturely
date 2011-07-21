# == Schema Information
# Schema version: 20110721122813
#
# Table name: albums
#
#  id                :integer(4)      not null, primary key
#  hashtag           :string(255)
#  shortcut          :string(255)
#  user_id           :integer(4)
#  number_picture    :integer(4)
#  number_text_tweet :integer(4)
#  number_upload     :integer(4)
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_albums_on_shortcut  (shortcut)
#

class Album < ActiveRecord::Base
  belongs_to :user

  has_many :search_results
  has_many :tweets, :through => :search_results
  
  validates :user_id, :presence => true
  ###   validates :shortcut, :uniqueness => true

  def add_tweet identifier, text, from_user_identifier, user_opt={}
    o = {
      :created_at => Time.now,
      :from_user => nil,
      :profile_image_url => nil,
      :source            => nil,
      :geo               => nil,
      :provider_name     => nil,
      :oembed_type       => nil,
      :url               => nil
    }.merge user_opt

    t = self.tweets.find_by_identifier identifier
    unless t
      # create_or_update
      t = Tweet.create_or_update(identifier, text, o[:created_at],
                                 from_user_identifier, o[:from_user],
                                 o[:profile_image_url], o[:source], o[:geo],
                                 o[:provider_name], o[:oembed_type], o[:url])
      self.tweets << t
    end

    t
  end
end
