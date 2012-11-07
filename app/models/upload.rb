# == Schema Information
# Schema version: 20110715101503
#
# Table name: uploads
#
#  id         :integer(4)      not null, primary key
#  link       :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Upload < ActiveRecord::Base
  belongs_to :user
end
