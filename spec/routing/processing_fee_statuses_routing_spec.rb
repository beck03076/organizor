require "spec_helper"

describe ProcessingFeeStatusesController do
  describe "routing" do

    it "routes to #index" do
      get("/processing_fee_statuses").should route_to("processing_fee_statuses#index")
    end

    it "routes to #new" do
      get("/processing_fee_statuses/new").should route_to("processing_fee_statuses#new")
    end

    it "routes to #show" do
      get("/processing_fee_statuses/1").should route_to("processing_fee_statuses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/processing_fee_statuses/1/edit").should route_to("processing_fee_statuses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/processing_fee_statuses").should route_to("processing_fee_statuses#create")
    end

    it "routes to #update" do
      put("/processing_fee_statuses/1").should route_to("processing_fee_statuses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/processing_fee_statuses/1").should route_to("processing_fee_statuses#destroy", :id => "1")
    end

  end
end
