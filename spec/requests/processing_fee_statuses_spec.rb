require 'spec_helper'

describe "ProcessingFeeStatuses" do
  describe "GET /processing_fee_statuses" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get processing_fee_statuses_path
      response.status.should be(200)
    end
  end
end
