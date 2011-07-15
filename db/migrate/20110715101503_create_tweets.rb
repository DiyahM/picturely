class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.integer :tweeter_id,                         :null => false
      t.integer :identifier,            :limit => 8, :null => false
      t.string :tweet_text
      t.timestamp :tweet_created_at
      t.string :source
      t.string :geo
      t.string :provider_name
      t.string :oembed_type
      t.string :url

      t.timestamps
    end

    add_index :tweets, :tweeter_id      # foreign key to tweeters table
    add_index :tweets, :identifier      # external Twitter tweet ID
  end

  def self.down
    remove_index :tweets, :identifier
    remove_index :tweets, :tweeter_id

    drop_table :tweets
  end
end
