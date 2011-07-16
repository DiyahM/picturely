require "spec_helper"

describe TweetersController do
  describe "routing" do

    it "routes to #index" do
      get("/tweeters").should route_to("tweeters#index")
    end

    it "routes to #new" do
      get("/tweeters/new").should route_to("tweeters#new")
    end

    it "routes to #show" do
      get("/tweeters/1").should route_to("tweeters#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tweeters/1/edit").should route_to("tweeters#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tweeters").should route_to("tweeters#create")
    end

    it "routes to #update" do
      put("/tweeters/1").should route_to("tweeters#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tweeters/1").should route_to("tweeters#destroy", :id => "1")
    end

  end
end
