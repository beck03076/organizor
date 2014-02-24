require 'spec_helper'

describe "commission_claim_statuses/edit" do
  before(:each) do
    @commission_claim_status = assign(:commission_claim_status, stub_model(CommissionClaimStatus,
      :name => "MyString",
      :desc => "MyText",
      :created_by => 1,
      :updated_by => 1
    ))
  end

  it "renders the edit commission_claim_status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", commission_claim_status_path(@commission_claim_status), "post" do
      assert_select "input#commission_claim_status_name[name=?]", "commission_claim_status[name]"
      assert_select "textarea#commission_claim_status_desc[name=?]", "commission_claim_status[desc]"
      assert_select "input#commission_claim_status_created_by[name=?]", "commission_claim_status[created_by]"
      assert_select "input#commission_claim_status_updated_by[name=?]", "commission_claim_status[updated_by]"
    end
  end
end
