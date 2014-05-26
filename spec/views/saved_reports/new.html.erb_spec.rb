require 'spec_helper'

describe "saved_reports/new" do
  before(:each) do
    assign(:saved_report, stub_model(SavedReport).as_new_record)
  end

  it "renders new saved_report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", saved_reports_path, "post" do
    end
  end
end
