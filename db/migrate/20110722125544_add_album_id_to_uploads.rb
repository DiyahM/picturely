class AddAlbumIdToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :album_id, :integer
  end

  def self.down
    remove_column :uploads, :album_id
  end
end
