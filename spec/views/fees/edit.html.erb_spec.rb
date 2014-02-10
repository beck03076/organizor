require 'spec_helper'

describe "fees/edit" do
  before(:each) do
    @fee = assign(:fee, stub_model(Fee,
      :tuition_fee_cents => 1,
      :commission_percentage => "MyString",
      :commission_amount_cents => 1,
      :programme_id => 1,
      :currency => "MyString",
      :scholarship_cents => 1,
      :created_by => 1,
      :updated_by => 1
    ))
  end

  it "renders the edit fee form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fee_path(@fee), "post" do
      assert_select "input#fee_tuition_fee_cents[name=?]", "fee[tuition_fee_cents]"
      assert_select "input#fee_commission_percentage[name=?]", "fee[commission_percentage]"
      assert_select "input#fee_commission_amount_cents[name=?]", "fee[commission_amount_cents]"
      assert_select "input#fee_programme_id[name=?]", "fee[programme_id]"
      assert_select "input#fee_currency[name=?]", "fee[currency]"
      assert_select "input#fee_scholarship_cents[name=?]", "fee[scholarship_cents]"
      assert_select "input#fee_created_by[name=?]", "fee[created_by]"
      assert_select "input#fee_updated_by[name=?]", "fee[updated_by]"
    end
  end
end
