require "spec_helper"

describe Source do

  it "should have many headlines" do
    should have_many(:headlines)
  end

  it "validates the presence of a name" do
    should validate_presence_of(:name)
  end
end
