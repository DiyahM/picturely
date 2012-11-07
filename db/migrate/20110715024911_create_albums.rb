class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :hashtag
      t.string :shortcut
      t.integer :user_id
      t.integer :number_picture
      t.integer :number_text_tweet
      t.integer :number_upload

      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
