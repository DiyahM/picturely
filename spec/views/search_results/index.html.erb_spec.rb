require 'spec_helper'

describe "search_results/index.html.erb" do
  before(:each) do
    assign(:search_results, [
      stub_model(SearchResult,
        :album_id => 111,
        :tweet_id => 111,
        :is_active => false
      ),
      stub_model(SearchResult,
        :album_id => 222,
        :tweet_id => 222,
        :is_active => false
      )
    ])
  end

  it "renders a list of search_results" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 111.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 222.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
