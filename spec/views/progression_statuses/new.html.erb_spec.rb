require 'spec_helper'

describe "progression_statuses/new" do
  before(:each) do
    assign(:progression_status, stub_model(ProgressionStatus,
      :name => "MyString",
      :desc => "MyText",
      :created_by => 1,
      :updated_by => 1
    ).as_new_record)
  end

  it "renders new progression_status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", progression_statuses_path, "post" do
      assert_select "input#progression_status_name[name=?]", "progression_status[name]"
      assert_select "textarea#progression_status_desc[name=?]", "progression_status[desc]"
      assert_select "input#progression_status_created_by[name=?]", "progression_status[created_by]"
      assert_select "input#progression_status_updated_by[name=?]", "progression_status[updated_by]"
    end
  end
end
