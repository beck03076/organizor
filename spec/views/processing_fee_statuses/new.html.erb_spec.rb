require 'spec_helper'

describe "processing_fee_statuses/new" do
  before(:each) do
    assign(:processing_fee_status, stub_model(ProcessingFeeStatus,
      :name => "MyString",
      :desc => "MyText",
      :created_by => 1,
      :updated_by => 1
    ).as_new_record)
  end

  it "renders new processing_fee_status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", processing_fee_statuses_path, "post" do
      assert_select "input#processing_fee_status_name[name=?]", "processing_fee_status[name]"
      assert_select "textarea#processing_fee_status_desc[name=?]", "processing_fee_status[desc]"
      assert_select "input#processing_fee_status_created_by[name=?]", "processing_fee_status[created_by]"
      assert_select "input#processing_fee_status_updated_by[name=?]", "processing_fee_status[updated_by]"
    end
  end
end
