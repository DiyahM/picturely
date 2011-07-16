# == Schema Information
# Schema version: 20110715101503
#
# Table name: pictures
#
#  id         :integer(4)      not null, primary key
#  image_host :string(255)
#  image_url  :string(255)
#  owner      :string(255)
#  tweet      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Picture < ActiveRecord::Base
end
