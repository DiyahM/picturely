require "spec_helper"

describe SearchResultsController do
  describe "routing" do

    it "routes to #index" do
      get("/search_results").should route_to("search_results#index")
    end

    it "routes to #new" do
      get("/search_results/new").should route_to("search_results#new")
    end

    it "routes to #show" do
      get("/search_results/1").should route_to("search_results#show", :id => "1")
    end

    it "routes to #edit" do
      get("/search_results/1/edit").should route_to("search_results#edit", :id => "1")
    end

    it "routes to #create" do
      post("/search_results").should route_to("search_results#create")
    end

    it "routes to #update" do
      put("/search_results/1").should route_to("search_results#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/search_results/1").should route_to("search_results#destroy", :id => "1")
    end

  end
end
