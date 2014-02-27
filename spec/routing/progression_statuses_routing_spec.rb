require "spec_helper"

describe ProgressionStatusesController do
  describe "routing" do

    it "routes to #index" do
      get("/progression_statuses").should route_to("progression_statuses#index")
    end

    it "routes to #new" do
      get("/progression_statuses/new").should route_to("progression_statuses#new")
    end

    it "routes to #show" do
      get("/progression_statuses/1").should route_to("progression_statuses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/progression_statuses/1/edit").should route_to("progression_statuses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/progression_statuses").should route_to("progression_statuses#create")
    end

    it "routes to #update" do
      put("/progression_statuses/1").should route_to("progression_statuses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/progression_statuses/1").should route_to("progression_statuses#destroy", :id => "1")
    end

  end
end
