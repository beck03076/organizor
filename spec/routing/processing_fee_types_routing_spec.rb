require "spec_helper"

describe ProcessingFeeTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/processing_fee_types").should route_to("processing_fee_types#index")
    end

    it "routes to #new" do
      get("/processing_fee_types/new").should route_to("processing_fee_types#new")
    end

    it "routes to #show" do
      get("/processing_fee_types/1").should route_to("processing_fee_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/processing_fee_types/1/edit").should route_to("processing_fee_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/processing_fee_types").should route_to("processing_fee_types#create")
    end

    it "routes to #update" do
      put("/processing_fee_types/1").should route_to("processing_fee_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/processing_fee_types/1").should route_to("processing_fee_types#destroy", :id => "1")
    end

  end
end
