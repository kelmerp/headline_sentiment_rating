require "spec_helper"

describe Headline do

  it "validates content has a maximum length of 255 characters" do
    should ensure_length_of(:content).is_at_most(255)
  end

  it "validates the presence of a date" do
    should validate_presence_of(:date)
  end

  it "validates the presence of an archive url" do
    should validate_presence_of(:archive_url)
  end


end
