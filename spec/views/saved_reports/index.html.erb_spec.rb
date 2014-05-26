require 'spec_helper'

describe "saved_reports/index" do
  before(:each) do
    assign(:saved_reports, [
      stub_model(SavedReport),
      stub_model(SavedReport)
    ])
  end

  it "renders a list of saved_reports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
