# == Schema Information
# Schema version: 20110823000016
#
# Table name: searches
#
#  id         :integer(4)      not null, primary key
#  term       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_searches_on_term  (term)
#

# Abstracts the idea of a search term that normalizes to a query. A
# Search belongs to a Query, and a Query has many Searches.
#
# This relationship is needed because although the search terms "#bali
# #indonesia" and "#INDONESIA #BALI" are equivalent to the Twitter
# search engine, they need to exist as separate entities to display to
# users.
#
class Search < ActiveRecord::Base

  def self.normalize_term str
    str.downcase.split(" or ").sort.join(" or ")
  end

end
