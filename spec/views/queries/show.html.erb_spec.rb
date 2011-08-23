require 'spec_helper'

describe "queries/show.html.erb" do
  before(:each) do
    @query = assign(:query, stub_model(Query,
      :term => "Term"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Term/)
  end
end
