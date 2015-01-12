require 'spec_helper'

describe "courses/show" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :name => "Name",
      :university => "University",
      :department => "Department",
      :qdmode => "Qdmode",
      :intake => "Intake",
      :requirements => "MyText",
      :intl => "MyText",
      :desc => "MyText",
      :ukfee => "MyText",
      :internfee => "MyText",
      :fund => "MyText",
      :named_pathway => "MyText",
      :new_enrollment => "MyText",
      :total_enrollment => "MyText",
      :scholarships => "MyText",
      :gscholarships => "MyText",
      :bursaries => "MyText",
      :contact_name => "Contact Name",
      :contact_email => "Contact Email",
      :contact_phone => "Contact Phone",
      :contact_web => "MyText",
      :apply_link => "Apply Link"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/University/)
    rendered.should match(/Department/)
    rendered.should match(/Qdmode/)
    rendered.should match(/Intake/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Contact Name/)
    rendered.should match(/Contact Email/)
    rendered.should match(/Contact Phone/)
    rendered.should match(/MyText/)
    rendered.should match(/Apply Link/)
  end
end
