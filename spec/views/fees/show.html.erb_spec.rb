require 'spec_helper'

describe "fees/show" do
  before(:each) do
    @fee = assign(:fee, stub_model(Fee,
      :tuition_fee_cents => 1,
      :commission_percentage => "Commission Percentage",
      :commission_amount_cents => 2,
      :programme_id => 3,
      :currency => "Currency",
      :scholarship_cents => 4,
      :created_by => 5,
      :updated_by => 6
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Commission Percentage/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Currency/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
  end
end
