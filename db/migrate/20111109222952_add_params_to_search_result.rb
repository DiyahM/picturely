class AddParamsToSearchResult < ActiveRecord::Migration
  def self.up
    add_column :search_results, :page, :integer
    add_column :search_results, :next_page, :string
    add_column :search_results, :prev_page, :string
    add_column :search_results, :refresh_url, :string
    add_column :search_results, :query, :string
  end

  def self.down
    remove_column :search_results, :query
    remove_column :search_results, :refresh_url
    remove_column :search_results, :prev_page
    remove_column :search_results, :next_page
    remove_column :search_results, :page
  end
end
