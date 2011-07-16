require 'spec_helper'

describe "tweeters/edit.html.erb" do
  before(:each) do
    @tweeter = assign(:tweeter, stub_model(Tweeter,
      :identifier => 1,
      :username => "MyString",
      :profile_image_url => "MyString"
    ))
  end

  it "renders the edit tweeter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tweeters_path(@tweeter), :method => "post" do
      assert_select "input#tweeter_identifier", :name => "tweeter[identifier]"
      assert_select "input#tweeter_username", :name => "tweeter[username]"
      assert_select "input#tweeter_profile_image_url", :name => "tweeter[profile_image_url]"
    end
  end
end
