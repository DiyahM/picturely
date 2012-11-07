# == Schema Information
# Schema version: 20110715101503
#
# Table name: tweeters
#
#  id                :integer(4)      not null, primary key
#  identifier        :integer(8)      not null
#  username          :string(255)
#  profile_image_url :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_tweeters_on_identifier  (identifier)
#  index_tweeters_on_username    (username)
#

class Tweeter < ActiveRecord::Base
  has_many :tweets
end
