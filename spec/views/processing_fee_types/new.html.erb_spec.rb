require 'spec_helper'

describe "processing_fee_types/new" do
  before(:each) do
    assign(:processing_fee_type, stub_model(ProcessingFeeType,
      :name => "MyString",
      :desc => "MyText",
      :created_by => 1,
      :updated_by => 1
    ).as_new_record)
  end

  it "renders new processing_fee_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", processing_fee_types_path, "post" do
      assert_select "input#processing_fee_type_name[name=?]", "processing_fee_type[name]"
      assert_select "textarea#processing_fee_type_desc[name=?]", "processing_fee_type[desc]"
      assert_select "input#processing_fee_type_created_by[name=?]", "processing_fee_type[created_by]"
      assert_select "input#processing_fee_type_updated_by[name=?]", "processing_fee_type[updated_by]"
    end
  end
end
