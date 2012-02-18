require "lolruby/lol_caption"
require "lolruby/lol_caption_data"
require "spec_helper"

describe LolCaption do
  before :each do
    @lol_caption = LolCaption.new
    @lol_caption.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
    
    @caption_data = LolCaptionData.new
    @caption_data.original_image   = "http://images.cheezburger.com/imagestore/2008/12/14/b8e71e41-c287-4ed3-af39-0ff4cdf4f817.jpg"
    @caption_data.text             = "Meow?"
    @caption_data.text_style       = "outline"
    @caption_data.font_size        = 25
    @caption_data.font_color       = "White"
    @caption_data.font_opacity     = 100
    @caption_data.font_family      = "Impact"
    @caption_data.is_bold          = "false"
    @caption_data.is_italic        = "false"
    @caption_data.is_underline     = "false"
    @caption_data.is_strikethrough = "false"
    @caption_data.x_position       = 10
    @caption_data.y_position       = 10
  end

  it "returns available fonts" do
    @lol_caption.caption_fonts.should include("Wingdings")
  end

  it "returns array of text styles" do
    @expected_array = ["outline","dropshadow","none"]
    @lol_caption.caption_text_style.should == @expected_array
  end

  it "gets dimensions of the caption" do
    xml = @lol_caption.build_caption_xml(@caption_data)
    response = @lol_caption.caption_dimensions(xml)
    response.should have_node("CaptionDimensions", :count => 1)
    response.should have_node("Width", :count => 1)
    response.should have_node("Height", :count => 1)
  end

  it "gets a preview of the caption" do
    ##Testing the hack for right now
    #xml = @lol_caption.build_caption_xml(@caption_data)
    #response = @lol_caption.caption_preview(xml)
    #puts response.inspect
    response_url = @lol_caption.caption_preview_hack(@caption_data)
    @caption_data.instance_variables.each do |var|
      response_url.should include(@caption_data.instance_variable_get(var).to_s)
    end
  end

  it "builds a caption xml" do
    xml = @lol_caption.build_caption_xml(@caption_data)
    puts xml.inspect
    xml.should have_node("caption", :count => 1)
    xml.should have_node("text", @caption_data.text, :count => 1)
  end

end