class AddTwitIdToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :id_str, :string
  end

  def self.down
    remove_column :pictures, :id_str
  end
end
