# == Schema Information
# Schema version: 20110716023153
#
# Table name: search_results
#
#  id         :integer(4)      not null, primary key
#  album_id   :integer(4)      not null
#  tweet_id   :integer(4)      not null
#  is_active  :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_search_results_on_album_id  (album_id)
#  index_search_results_on_tweet_id  (tweet_id)
#

class SearchResult < ActiveRecord::Base
  belongs_to :album
  belongs_to :tweet
end
