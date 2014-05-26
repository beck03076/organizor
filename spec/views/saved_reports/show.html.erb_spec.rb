require 'spec_helper'

describe "saved_reports/show" do
  before(:each) do
    @saved_report = assign(:saved_report, stub_model(SavedReport))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
