require 'spec_helper'

describe "sliding_scales/show" do
  before(:each) do
    @sliding_scale = assign(:sliding_scale, stub_model(SlidingScale))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
