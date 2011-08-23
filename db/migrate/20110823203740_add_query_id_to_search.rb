class AddQueryIdToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :query_id, :integer, :null => false
    add_index :searches, :query_id
  end

  def self.down
    remove_index :searches, :query_id
    remove_column :searches, :query_id
  end
end
