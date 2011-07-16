# == Schema Information
# Schema version: 20110715101503
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

class Album < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, :presence => true
end
