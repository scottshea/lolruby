# -*- encoding : utf-8 -*-
require "lolruby/lol_content_submission"
require "spec_helper"

describe LolContentSubmission do
  before :each do
    @lol_content_submission = LolContentSubmission.new
    @lol_content_submission.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
    
    @picture = LolPictureSubmission.new
    @picture.title       = "koala"
    @picture.file_path   = "./spec/koala.jpg"
    @picture.description = "It's a koala"
    @picture.attribution = "Windows Sample Pictures"
  end

  it "should build picture xml" do
    xml = @lol_content_submission.build_picture_xml(@picture)
    xml.should have_node("EncodedPicture", :count => 1)
    xml.should have_node("Title", :count => 1)
    xml.should have_node("Description", :count => 1)
    xml.should have_node("Attribution", :count => 1)
    xml.should have_node("AttributionUrl", :count => 1)
    xml.should have_node("Base64EncodedImage", :count => 1)
  end

  it "should submit a picture successfully" do
    xml = @lol_content_submission.build_picture_xml(@picture)
    response = @lol_content_submission.submit_picture(xml, "2053bb50-5b53-4c72-8217-4cc2eef00686")
    puts "XX: " + response.inspect
    true.should == false
  end
end
