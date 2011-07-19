require 'spec_helper'

describe "search_results/new.html.erb" do
  before(:each) do
    assign(:search_result, stub_model(SearchResult,
      :album_id => 1,
      :tweet_id => 1,
      :is_active => false
    ).as_new_record)
  end

  it "renders new search_result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => search_results_path, :method => "post" do
      assert_select "input#search_result_album_id", :name => "search_result[album_id]"
      assert_select "input#search_result_tweet_id", :name => "search_result[tweet_id]"
      assert_select "input#search_result_is_active", :name => "search_result[is_active]"
    end
  end
end
