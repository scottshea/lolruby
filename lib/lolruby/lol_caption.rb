require "lolruby/lol_base"
require "lolruby/lol_caption_data"
require "builder"

class LolCaption < Lolruby::LolBase

  def caption_fonts
    caption_font_url = "http://api.cheezburger.com/xml/captions/fonts"
    lol_fonts = get_lol_xml(caption_font_url,"//FontFamilyList")[0]["FontFamilies"].split("\n").map {|font| font.lstrip}
    lol_fonts.delete_if {|font| font == ""}
    #puts lol_fonts.inspect
    #puts font_array.class.inspect + "; " + font_array.inspect
  end

  def caption_text_style
    #they only support the three items now and there is no REST call to make to get the list
    Array["outline","dropshadow","none"]
  end

  def caption_preview
    caption_preview_url = "http://api.cheezburger.com/xml/captions/preview"
  end

  def caption_dimensions
    caption_dimension_url = "http://api.cheezburger.com/xml/captions/dimensions"
    response = RestClient.post caption_dimension_url, :DeveloperKey => api_key
    puts response
  end

  def build_caption_xml(lol_caption_data)
    xml = Builder::XmlMarkup.new( :indent => 2 )
    xml.instruct! :xml, :encoding => "ASCII"
    xml.Caption do |element|
      element.Text            lol_caption_data.text
      element.FontFamily      lol_caption_data.font_family
      element.FontSize        lol_caption_data.font_size
      element.FontColor       lol_caption_data.font_color
      element.XPosition       lol_caption_data.x_position
      element.YPosition       lol_caption_data.y_position
      element.IsBold          lol_caption_data.is_bold
      element.TextStyle       lol_caption_data.text_style
      element.IsItalic        lol_caption_data.is_italic
      element.IsStrikeThrough lol_caption_data.is_strikethrough
      element.IsUnderline     lol_caption_data.is_underline
      element.Opacity         lol_caption_data.font_opacity
    end
    return xml
  end

end