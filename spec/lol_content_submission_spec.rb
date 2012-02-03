require "lolruby/lol_content_submission"
require "rspec"
require "yaml"

describe LolContentSubmission do

  it "should build xml" do
    xml_builder = LolContentSubmission.new
    xml_builder.build_picture_xml

    true.should == false
  end
end