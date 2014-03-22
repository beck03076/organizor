require 'spec_helper'

describe "processing_fee_statuses/show" do
  before(:each) do
    @processing_fee_status = assign(:processing_fee_status, stub_model(ProcessingFeeStatus,
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
