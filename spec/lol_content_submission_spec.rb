require "lolruby/lol_content_submission"
require "rspec"
require "yaml"

describe LolContentSubmission do

  it "should build xml" do
    xml_builder = LolContentSubmission.new
    picture = LolPictureSubmission.new
    picture.title       = "koala"
    picture.file_path   = "./spec/koala.jpg"
    picture.description = "It's a koala"
    picture.attribution = "Windows Sample Pictures"
    response = xml_builder.build_picture_xml(picture)
    puts response.class

    true.should == false
  end
end