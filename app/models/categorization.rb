class Categorization < ActiveRecord::Base
  belongs_to :picture
  belongs_to :keyword
end
