class AddNewAttrToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :geo, :string
    add_column :pictures, :retweet_count, :string
    add_column :pictures, :in_reply_to_screen_name, :string
    add_column :pictures, :in_reply_to_user_id, :string
    add_column :pictures, :possibly_sensitive, :string
    add_column :pictures, :coordinates, :string
    add_column :pictures, :retweeted, :string
    add_column :pictures, :in_reply_to_status_id_str, :string
    add_column :pictures, :place, :string
    add_column :pictures, :in_reply_to_status_id, :string
    add_column :pictures, :in_reply_to_user_id_str, :string
  end

  def self.down
    remove_column :pictures, :in_reply_to_user_id_str
    remove_column :pictures, :in_reply_to_status_id
    remove_column :pictures, :place
    remove_column :pictures, :in_reply_to_status_id_str
    remove_column :pictures, :retweeted
    remove_column :pictures, :coordinates
    remove_column :pictures, :possibly_sensitive
    remove_column :pictures, :in_reply_to_user_id
    remove_column :pictures, :in_reply_to_screen_name
    remove_column :pictures, :retweet_count
    remove_column :pictures, :geo
  end
end
