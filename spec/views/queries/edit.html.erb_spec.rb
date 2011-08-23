require 'spec_helper'

describe "queries/edit.html.erb" do
  before(:each) do
    @query = assign(:query, stub_model(Query,
      :term => "MyString"
    ))
  end

  it "renders the edit query form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => queries_path(@query), :method => "post" do
      assert_select "input#query_term", :name => "query[term]"
    end
  end
end
