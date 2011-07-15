require 'spec_helper'

describe "tweeters/show.html.erb" do
  before(:each) do
    @tweeter = assign(:tweeter, stub_model(Tweeter,
      :identifier => 1,
      :username => "Username",
      :profile_image_url => "Profile Image Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Username/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Profile Image Url/)
  end
end
