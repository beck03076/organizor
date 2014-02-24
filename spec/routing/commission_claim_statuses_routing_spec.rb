require "spec_helper"

describe CommissionClaimStatusesController do
  describe "routing" do

    it "routes to #index" do
      get("/commission_claim_statuses").should route_to("commission_claim_statuses#index")
    end

    it "routes to #new" do
      get("/commission_claim_statuses/new").should route_to("commission_claim_statuses#new")
    end

    it "routes to #show" do
      get("/commission_claim_statuses/1").should route_to("commission_claim_statuses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/commission_claim_statuses/1/edit").should route_to("commission_claim_statuses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/commission_claim_statuses").should route_to("commission_claim_statuses#create")
    end

    it "routes to #update" do
      put("/commission_claim_statuses/1").should route_to("commission_claim_statuses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/commission_claim_statuses/1").should route_to("commission_claim_statuses#destroy", :id => "1")
    end

  end
end
