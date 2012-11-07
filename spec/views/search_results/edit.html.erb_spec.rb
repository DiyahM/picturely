require 'spec_helper'

describe "search_results/edit.html.erb" do
  before(:each) do
    @search_result = assign(:search_result, stub_model(SearchResult,
      :album_id => 1,
      :tweet_id => 1,
      :is_active => false
    ))
  end

  it "renders the edit search_result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => search_results_path(@search_result), :method => "post" do
      assert_select "input#search_result_album_id", :name => "search_result[album_id]"
      assert_select "input#search_result_tweet_id", :name => "search_result[tweet_id]"
      assert_select "input#search_result_is_active", :name => "search_result[is_active]"
    end
  end
end
