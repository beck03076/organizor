require "spec_helper"

describe FeesController do
  describe "routing" do

    it "routes to #index" do
      get("/fees").should route_to("fees#index")
    end

    it "routes to #new" do
      get("/fees/new").should route_to("fees#new")
    end

    it "routes to #show" do
      get("/fees/1").should route_to("fees#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fees/1/edit").should route_to("fees#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fees").should route_to("fees#create")
    end

    it "routes to #update" do
      put("/fees/1").should route_to("fees#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fees/1").should route_to("fees#destroy", :id => "1")
    end

  end
end
