# == Schema Information
# Schema version: 20110823010653
#
# Table name: queries
#
#  id         :integer(4)      not null, primary key
#  term       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_queries_on_term  (term)
#

# This model stores a normalized query calculated from a Search term -
# this allows two different search terms that have the same search
# semantic to be submitted by Twitter search only once. For example,
# the search terms "#bali #indonesia" is equivalent to "#BALI
# #INDONESIA" as far as Twitter is concerned. Thus, we store them as
# separate search terms that belongs to the same normalized query
# "#bali #indonesia".
#
class Query < ActiveRecord::Base
end
