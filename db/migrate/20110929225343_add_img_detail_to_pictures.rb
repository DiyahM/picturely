class AddImgDetailToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :image_host, :string
    add_column :pictures, :image_url, :string
  end

  def self.down
    remove_column :pictures, :image_url
    remove_column :pictures, :image_host
  end
end
