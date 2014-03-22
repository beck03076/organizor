require 'spec_helper'

describe "processing_fee_statuses/edit" do
  before(:each) do
    @processing_fee_status = assign(:processing_fee_status, stub_model(ProcessingFeeStatus,
      :name => "MyString",
      :desc => "MyText",
      :created_by => 1,
      :updated_by => 1
    ))
  end

  it "renders the edit processing_fee_status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", processing_fee_status_path(@processing_fee_status), "post" do
      assert_select "input#processing_fee_status_name[name=?]", "processing_fee_status[name]"
      assert_select "textarea#processing_fee_status_desc[name=?]", "processing_fee_status[desc]"
      assert_select "input#processing_fee_status_created_by[name=?]", "processing_fee_status[created_by]"
      assert_select "input#processing_fee_status_updated_by[name=?]", "processing_fee_status[updated_by]"
    end
  end
end
