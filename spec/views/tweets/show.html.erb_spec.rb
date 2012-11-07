require 'spec_helper'

describe "tweets/show.html.erb" do
  before(:each) do
    @tweet = assign(:tweet, stub_model(Tweet,
      :tweeter_id => 1,
      :identifier => 1,
      :tweet_text => "Tweet Text",
      :source => "Source",
      :geo => "Geo",
      :provider_name => "Provider Name",
      :oembed_type => "Oembed Type",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tweet Text/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Source/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Geo/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Provider Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Oembed Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
  end
end
