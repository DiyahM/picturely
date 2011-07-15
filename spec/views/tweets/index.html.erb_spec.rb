require 'spec_helper'

describe "tweets/index.html.erb" do
  before(:each) do
    assign(:tweets, [
      stub_model(Tweet,
        :tweeter_id => 1,
        :identifier => 1,
        :tweet_text => "Tweet Text",
        :source => "Source",
        :geo => "Geo",
        :provider_name => "Provider Name",
        :oembed_type => "Oembed Type",
        :url => "Url"
      ),
      stub_model(Tweet,
        :tweeter_id => 1,
        :identifier => 1,
        :tweet_text => "Tweet Text",
        :source => "Source",
        :geo => "Geo",
        :provider_name => "Provider Name",
        :oembed_type => "Oembed Type",
        :url => "Url"
      )
    ])
  end

  it "renders a list of tweets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Tweet Text".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Geo".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Provider Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Oembed Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
