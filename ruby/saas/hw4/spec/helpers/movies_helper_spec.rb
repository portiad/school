require "spec_helper"

describe MoviesHelper do
  it "is ok" do
    helper.oddness(1).should == "odd"
    helper.oddness(2).should == "even"
  end
end
