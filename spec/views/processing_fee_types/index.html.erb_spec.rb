require 'spec_helper'

describe "processing_fee_types/index" do
  before(:each) do
    assign(:processing_fee_types, [
      stub_model(ProcessingFeeType,
        :name => "Name",
        :desc => "MyText",
        :created_by => 1,
        :updated_by => 2
      ),
      stub_model(ProcessingFeeType,
        :name => "Name",
        :desc => "MyText",
        :created_by => 1,
        :updated_by => 2
      )
    ])
  end

  it "renders a list of processing_fee_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
