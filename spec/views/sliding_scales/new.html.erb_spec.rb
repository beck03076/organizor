require 'spec_helper'

describe "sliding_scales/new" do
  before(:each) do
    assign(:sliding_scale, stub_model(SlidingScale).as_new_record)
  end

  it "renders new sliding_scale form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sliding_scales_path, "post" do
    end
  end
end
