class AddMoreToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :user, :string
    add_column :pictures, :contributors, :string
    add_column :pictures, :truncated, :string
    add_column :pictures, :source, :string
    add_column :pictures, :favorited, :string
    add_column :pictures, :text, :string
    add_column :pictures, :url, :string
  end

  def self.down
    remove_column :pictures, :url
    remove_column :pictures, :text
    remove_column :pictures, :favorited
    remove_column :pictures, :source
    remove_column :pictures, :truncated
    remove_column :pictures, :contributors
    remove_column :pictures, :user
  end
end
