require 'spec_helper'

describe "tweets/new.html.erb" do
  before(:each) do
    assign(:tweet, stub_model(Tweet,
      :tweeter_id => 1,
      :identifier => 1,
      :tweet_text => "MyString",
      :source => "MyString",
      :geo => "MyString",
      :provider_name => "MyString",
      :oembed_type => "MyString",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new tweet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tweets_path, :method => "post" do
      assert_select "input#tweet_tweeter_id", :name => "tweet[tweeter_id]"
      assert_select "input#tweet_identifier", :name => "tweet[identifier]"
      assert_select "input#tweet_tweet_text", :name => "tweet[tweet_text]"
      assert_select "input#tweet_source", :name => "tweet[source]"
      assert_select "input#tweet_geo", :name => "tweet[geo]"
      assert_select "input#tweet_provider_name", :name => "tweet[provider_name]"
      assert_select "input#tweet_oembed_type", :name => "tweet[oembed_type]"
      assert_select "input#tweet_url", :name => "tweet[url]"
    end
  end
end
