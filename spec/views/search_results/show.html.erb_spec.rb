require 'spec_helper'

describe "search_results/show.html.erb" do
  before(:each) do
    @search_result = assign(:search_result, stub_model(SearchResult,
      :album_id => 1,
      :tweet_id => 1,
      :is_active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
