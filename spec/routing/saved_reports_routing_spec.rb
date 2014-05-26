require "spec_helper"

describe SavedReportsController do
  describe "routing" do

    it "routes to #index" do
      get("/saved_reports").should route_to("saved_reports#index")
    end

    it "routes to #new" do
      get("/saved_reports/new").should route_to("saved_reports#new")
    end

    it "routes to #show" do
      get("/saved_reports/1").should route_to("saved_reports#show", :id => "1")
    end

    it "routes to #edit" do
      get("/saved_reports/1/edit").should route_to("saved_reports#edit", :id => "1")
    end

    it "routes to #create" do
      post("/saved_reports").should route_to("saved_reports#create")
    end

    it "routes to #update" do
      put("/saved_reports/1").should route_to("saved_reports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/saved_reports/1").should route_to("saved_reports#destroy", :id => "1")
    end

  end
end
