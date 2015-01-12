require 'spec_helper'

describe "courses/new" do
  before(:each) do
    assign(:course, stub_model(Course,
      :name => "MyString",
      :university => "MyString",
      :department => "MyString",
      :qdmode => "MyString",
      :intake => "MyString",
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
      :contact_name => "MyString",
      :contact_email => "MyString",
      :contact_phone => "MyString",
      :contact_web => "MyText",
      :apply_link => "MyString"
    ).as_new_record)
  end

  it "renders new course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", courses_path, "post" do
      assert_select "input#course_name[name=?]", "course[name]"
      assert_select "input#course_university[name=?]", "course[university]"
      assert_select "input#course_department[name=?]", "course[department]"
      assert_select "input#course_qdmode[name=?]", "course[qdmode]"
      assert_select "input#course_intake[name=?]", "course[intake]"
      assert_select "textarea#course_requirements[name=?]", "course[requirements]"
      assert_select "textarea#course_intl[name=?]", "course[intl]"
      assert_select "textarea#course_desc[name=?]", "course[desc]"
      assert_select "textarea#course_ukfee[name=?]", "course[ukfee]"
      assert_select "textarea#course_internfee[name=?]", "course[internfee]"
      assert_select "textarea#course_fund[name=?]", "course[fund]"
      assert_select "textarea#course_named_pathway[name=?]", "course[named_pathway]"
      assert_select "textarea#course_new_enrollment[name=?]", "course[new_enrollment]"
      assert_select "textarea#course_total_enrollment[name=?]", "course[total_enrollment]"
      assert_select "textarea#course_scholarships[name=?]", "course[scholarships]"
      assert_select "textarea#course_gscholarships[name=?]", "course[gscholarships]"
      assert_select "textarea#course_bursaries[name=?]", "course[bursaries]"
      assert_select "input#course_contact_name[name=?]", "course[contact_name]"
      assert_select "input#course_contact_email[name=?]", "course[contact_email]"
      assert_select "input#course_contact_phone[name=?]", "course[contact_phone]"
      assert_select "textarea#course_contact_web[name=?]", "course[contact_web]"
      assert_select "input#course_apply_link[name=?]", "course[apply_link]"
    end
  end
end
