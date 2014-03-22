require 'spec_helper'

describe "processing_fee_statuses/index" do
  before(:each) do
    assign(:processing_fee_statuses, [
      stub_model(ProcessingFeeStatus,
        :name => "Name",
        :desc => "MyText",
        :created_by => 1,
        :updated_by => 2
      ),
      stub_model(ProcessingFeeStatus,
        :name => "Name",
        :desc => "MyText",
        :created_by => 1,
        :updated_by => 2
      )
    ])
  end

  it "renders a list of processing_fee_statuses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
