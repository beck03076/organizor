require 'spec_helper'

describe "fees/index" do
  before(:each) do
    assign(:fees, [
      stub_model(Fee,
        :tuition_fee_cents => 1,
        :commission_percentage => "Commission Percentage",
        :commission_amount_cents => 2,
        :programme_id => 3,
        :currency => "Currency",
        :scholarship_cents => 4,
        :created_by => 5,
        :updated_by => 6
      ),
      stub_model(Fee,
        :tuition_fee_cents => 1,
        :commission_percentage => "Commission Percentage",
        :commission_amount_cents => 2,
        :programme_id => 3,
        :currency => "Currency",
        :scholarship_cents => 4,
        :created_by => 5,
        :updated_by => 6
      )
    ])
  end

  it "renders a list of fees" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Commission Percentage".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Currency".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
