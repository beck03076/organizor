require 'spec_helper'

describe "courses/index" do
  before(:each) do
    assign(:courses, [
      stub_model(Course,
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
      ),
      stub_model(Course,
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
      )
    ])
  end

  it "renders a list of courses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "University".to_s, :count => 2
    assert_select "tr>td", :text => "Department".to_s, :count => 2
    assert_select "tr>td", :text => "Qdmode".to_s, :count => 2
    assert_select "tr>td", :text => "Intake".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Contact Name".to_s, :count => 2
    assert_select "tr>td", :text => "Contact Email".to_s, :count => 2
    assert_select "tr>td", :text => "Contact Phone".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Apply Link".to_s, :count => 2
  end
end
