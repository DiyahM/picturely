require 'spec_helper'

describe Search do
  describe "#normalize" do
    it "should return a normalized query string" do
      Search.normalize_term("#bali #indonesia").should == "#bali #indonesia"
    end

    it "should downcase query strings" do
      Search.normalize_term("#BALI #INDONESIA").should == "#bali #indonesia"
    end

    it "should order OR search clauses" do
      Search.normalize_term("ZOO OR FOO OR BAR").should == "bar or foo or zoo"
    end
  end
end
