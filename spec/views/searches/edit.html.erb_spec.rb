require 'spec_helper'

describe "searches/edit.html.erb" do
  before(:each) do
    @search = assign(:search, stub_model(Search,
      :term => "MyString"
    ))
  end

  it "renders the edit search form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => searches_path(@search), :method => "post" do
      assert_select "input#search_term", :name => "search[term]"
    end
  end
end
