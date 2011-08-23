require 'spec_helper'

describe "queries/new.html.erb" do
  before(:each) do
    assign(:query, stub_model(Query,
      :term => "MyString"
    ).as_new_record)
  end

  it "renders new query form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => queries_path, :method => "post" do
      assert_select "input#query_term", :name => "query[term]"
    end
  end
end
