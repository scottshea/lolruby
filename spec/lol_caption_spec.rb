require "lolruby/lol_caption"
require "spec_helper"

describe LolCaption do
  before :each do
    @lol_caption = LolCaption.new
    @lol_caption.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
  end

  it "returns available fonts" do
    @lol_caption.caption_fonts.should include("Wingdings")
  end

  it "returns array of text styles" do
    @expected_array = ["outline","dropshadow","none"]
    @lol_caption.caption_text_style.should == @expected_array
  end
end