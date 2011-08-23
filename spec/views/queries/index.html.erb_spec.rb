require 'spec_helper'

describe "queries/index.html.erb" do
  before(:each) do
    assign(:queries, [
      stub_model(Query,
        :term => "Term"
      ),
      stub_model(Query,
        :term => "Term"
      )
    ])
  end

  it "renders a list of queries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Term".to_s, :count => 2
  end
end
