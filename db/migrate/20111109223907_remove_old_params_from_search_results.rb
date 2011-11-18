class RemoveOldParamsFromSearchResults < ActiveRecord::Migration
  def self.up
    remove_column :search_results, :album_id
    remove_column :search_results, :tweet_id
    remove_column :search_results, :is_active
  end

  def self.down
    add_column :search_results, :is_active, :boolean
    add_column :search_results, :tweet_id, :integer
    add_column :search_results, :album_id, :integer
  end
end
