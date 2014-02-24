require 'spec_helper'

describe "commission_claim_statuses/index" do
  before(:each) do
    assign(:commission_claim_statuses, [
      stub_model(CommissionClaimStatus,
        :name => "Name",
        :desc => "MyText",
        :created_by => 1,
        :updated_by => 2
      ),
      stub_model(CommissionClaimStatus,
        :name => "Name",
        :desc => "MyText",
        :created_by => 1,
        :updated_by => 2
      )
    ])
  end

  it "renders a list of commission_claim_statuses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
