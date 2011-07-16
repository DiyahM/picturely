class CreateSearchResults < ActiveRecord::Migration
  def self.up
    create_table :search_results do |t|
      t.integer :album_id,      :null => false
      t.integer :tweet_id,      :null => false
      t.boolean :is_active

      t.timestamps
    end

    add_index :search_results, :album_id
    add_index :search_results, :tweet_id
  end

  def self.down
    remove_index :search_results, :tweet_id
    remove_index :search_results, :album_id

    drop_table :search_results
  end
end
