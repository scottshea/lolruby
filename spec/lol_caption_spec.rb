require "lolruby/lol_caption"
require "lolruby/lol_caption_data"
require "spec_helper"

describe LolCaption do
  before :each do
    @lol_caption = LolCaption.new
    @lol_caption.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
    
    @caption_data = LolCaptionData.new
    @caption_data.text = "Meow?"
    @caption_data.text_style = "outline"
    @caption_data.font_size = 25
    @caption_data.font_color = "White"
    @caption_data.font_opacity = 100
    @caption_data.font_family = "Impact"
    @caption_data.is_bold = "false"
    @caption_data.is_italic = "false"
    @caption_data.is_underline = "false"
    @caption_data.is_strikethrough = "false"
    @caption_data.x_position = 10
    @caption_data.y_position = 10
  end

  it "returns available fonts" do
    @lol_caption.caption_fonts.should include("Wingdings")
  end

  it "returns array of text styles" do
    @expected_array = ["outline","dropshadow","none"]
    @lol_caption.caption_text_style.should == @expected_array
  end

  it "gets dimensions of the caption" do
    @lol_caption.caption_dimensions
    true.should == false
  end

  it "builds a caption xml" do
    xml = @lol_caption.build_caption_xml(@caption_data)
    puts xml.inspect
    true.should == false
  end

end