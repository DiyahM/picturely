require 'spec_helper'
require 'tweet_searcher'

describe TweetSearcher do
  before :each do
    @ts = TweetSearcher.new("#bali")
  end

  describe "#new" do
    it "should take a search query as argument" do
      @ts.should_not be_nil
    end
  end

  describe "#search" do
    before :each do
      @hsh = @ts.search
    end

    it "should return hash with 'next_page' key" do
      @hsh['next_page'].should_not be_nil
    end

    it "should return hash with 'refresh_url' key" do
      @hsh['refresh_url'].should_not be_nil
    end

    it "should return hash with 'results' array of 100 elements" do
      @hsh['results'].size.should == 100
    end

    it "should return hash with 'results' array without retweets" do
      retweets = @hsh['results'].select {|tweet| tweet['text'].include? " RT "}
      retweets.size.should == 0
    end
  end
end


