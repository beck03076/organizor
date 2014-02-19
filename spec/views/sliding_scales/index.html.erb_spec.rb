require 'spec_helper'

describe "sliding_scales/index" do
  before(:each) do
    assign(:sliding_scales, [
      stub_model(SlidingScale),
      stub_model(SlidingScale)
    ])
  end

  it "renders a list of sliding_scales" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
