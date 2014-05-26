require 'spec_helper'

describe "saved_reports/edit" do
  before(:each) do
    @saved_report = assign(:saved_report, stub_model(SavedReport))
  end

  it "renders the edit saved_report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", saved_report_path(@saved_report), "post" do
    end
  end
end
