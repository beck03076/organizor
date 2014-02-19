require 'spec_helper'

describe "sliding_scales/edit" do
  before(:each) do
    @sliding_scale = assign(:sliding_scale, stub_model(SlidingScale))
  end

  it "renders the edit sliding_scale form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sliding_scale_path(@sliding_scale), "post" do
    end
  end
end
