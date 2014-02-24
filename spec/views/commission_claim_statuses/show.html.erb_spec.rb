require 'spec_helper'

describe "commission_claim_statuses/show" do
  before(:each) do
    @commission_claim_status = assign(:commission_claim_status, stub_model(CommissionClaimStatus,
      :name => "Name",
      :desc => "MyText",
      :created_by => 1,
      :updated_by => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
