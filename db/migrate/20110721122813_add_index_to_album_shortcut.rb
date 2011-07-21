class AddIndexToAlbumShortcut < ActiveRecord::Migration
  def self.up
    add_index :albums, :shortcut
  end

  def self.down
    remove_index :albums, :shortcut
  end
end
