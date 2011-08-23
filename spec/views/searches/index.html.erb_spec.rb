require 'spec_helper'

describe "searches/index.html.erb" do
  before(:each) do
    assign(:searches, [
      stub_model(Search,
        :term => "Term"
      ),
      stub_model(Search,
        :term => "Term"
      )
    ])
  end

  it "renders a list of searches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Term".to_s, :count => 2
  end
end
