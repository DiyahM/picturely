class AddThumbnailsToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :medium_thumbnail, :string
    add_column :pictures, :small_thumbnail, :string
  end

  def self.down
    remove_column :pictures, :small_thumbnail
    remove_column :pictures, :medium_thumbnail
  end
end
