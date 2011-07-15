require 'spec_helper'

describe "tweeters/index.html.erb" do
  before(:each) do
    assign(:tweeters, [
      stub_model(Tweeter,
        :identifier => 1,
        :username => "Username",
        :profile_image_url => "Profile Image Url"
      ),
      stub_model(Tweeter,
        :identifier => 1,
        :username => "Username",
        :profile_image_url => "Profile Image Url"
      )
    ])
  end

  it "renders a list of tweeters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Profile Image Url".to_s, :count => 2
  end
end
