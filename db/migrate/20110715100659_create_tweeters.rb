class CreateTweeters < ActiveRecord::Migration
  def self.up
    create_table :tweeters do |t|
      t.integer :identifier,		:limit => 8, :null => false
      t.string :username
      t.string :profile_image_url

      t.timestamps
    end

    add_index :tweeters, :identifier
    add_index :tweeters, :username
  end

  def self.down
    remove_index :tweeters, :username
    remove_index :tweeters, :identifier

    drop_table :tweeters
  end
end
