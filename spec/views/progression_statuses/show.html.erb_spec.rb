require 'spec_helper'

describe "progression_statuses/show" do
  before(:each) do
    @progression_status = assign(:progression_status, stub_model(ProgressionStatus,
      :name => "Name",
      :desc => "MyText",
      :created_by => 1,
      :updated_by => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
