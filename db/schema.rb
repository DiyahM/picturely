# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111109223907) do

  create_table "albums", :force => true do |t|
    t.string   "hashtag"
    t.string   "shortcut"
    t.integer  "user_id"
    t.integer  "number_picture"
    t.integer  "number_text_tweet"
    t.integer  "number_upload"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["shortcut"], :name => "index_albums_on_shortcut"

  create_table "categorizations", :force => true do |t|
    t.integer  "picture_id"
    t.integer  "keyword_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", :force => true do |t|
    t.string   "term"
    t.integer  "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "id_str"
    t.string   "geo"
    t.string   "retweet_count"
    t.string   "in_reply_to_screen_name"
    t.string   "in_reply_to_user_id"
    t.string   "possibly_sensitive"
    t.string   "coordinates"
    t.string   "retweeted"
    t.string   "in_reply_to_status_id_str"
    t.string   "place"
    t.string   "in_reply_to_status_id"
    t.string   "in_reply_to_user_id_str"
    t.string   "user"
    t.string   "contributors"
    t.string   "truncated"
    t.string   "source"
    t.string   "favorited"
    t.string   "text"
    t.string   "url"
    t.string   "image_host"
    t.string   "image_url"
    t.string   "medium_thumbnail"
    t.string   "small_thumbnail"
  end

  create_table "search_results", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page"
    t.string   "next_page"
    t.string   "prev_page"
    t.string   "refresh_url"
    t.string   "query"
  end

  create_table "searches", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "uname"
    t.string   "uemail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweeters", :force => true do |t|
    t.integer  "identifier",        :limit => 8, :null => false
    t.string   "username"
    t.string   "profile_image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweeters", ["identifier"], :name => "index_tweeters_on_identifier"
  add_index "tweeters", ["username"], :name => "index_tweeters_on_username"

  create_table "tweets", :force => true do |t|
    t.integer  "tweeter_id",                    :null => false
    t.integer  "identifier",       :limit => 8, :null => false
    t.string   "tweet_text"
    t.datetime "tweet_created_at"
    t.string   "source"
    t.string   "geo"
    t.string   "provider_name"
    t.string   "oembed_type"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["identifier"], :name => "index_tweets_on_identifier"
  add_index "tweets", ["tweeter_id"], :name => "index_tweets_on_tweeter_id"

  create_table "uploads", :force => true do |t|
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
