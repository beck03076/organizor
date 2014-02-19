require "spec_helper"

describe SlidingScalesController do
  describe "routing" do

    it "routes to #index" do
      get("/sliding_scales").should route_to("sliding_scales#index")
    end

    it "routes to #new" do
      get("/sliding_scales/new").should route_to("sliding_scales#new")
    end

    it "routes to #show" do
      get("/sliding_scales/1").should route_to("sliding_scales#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sliding_scales/1/edit").should route_to("sliding_scales#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sliding_scales").should route_to("sliding_scales#create")
    end

    it "routes to #update" do
      put("/sliding_scales/1").should route_to("sliding_scales#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sliding_scales/1").should route_to("sliding_scales#destroy", :id => "1")
    end

  end
end
