class RemoveAttrFromPictures < ActiveRecord::Migration
  def self.up
    remove_column :pictures, :image_host
    remove_column :pictures, :image_url
    remove_column :pictures, :owner
    remove_column :pictures, :tweet
  end

  def self.down
    add_column :pictures, :tweet, :string
    add_column :pictures, :owner, :string
    add_column :pictures, :image_url, :string
    add_column :pictures, :image_host, :string
  end
end
