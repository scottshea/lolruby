require "lolruby/lol_base"
require "lolruby/lol_caption_data"
require "builder"
require "uri"
require "cgi"

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

  def caption_preview(caption_xml)
    caption_preview_url = "http://api.cheezburger.com/xml/captions/preview"
    puts caption_xml.inspect
    encoded_xml = "%3C%3Fxml%20version%3D%221.0%22%20encoding%3D%22utf-8%22%3F%3E%0A%3CCaption%3E%0A%20%20%3CText%3EMeow%3F%3C%2FText%3E%0A%20%20%3CFontFamily%3EImpact%3C%2FFontFamily%3E%0A%20%20%3CFontSize%3E25%3C%2FFontSize%3E%0A%20%20%3CFontColor%3EWhite%3C%2FFontColor%3E%0A%20%20%3CXPosition%3E10%3C%2FXPosition%3E%0A%20%20%3CYPosition%3E10%3C%2FYPosition%3E%0A%20%20%3CIsBold%3Efalse%3C%2FIsBold%3E%0A%20%20%3CTextStyle%3Eoutline%3C%2FTextStyle%3E%0A%20%20%3CIsItalic%3Efalse%3C%2FIsItalic%3E%0A%20%20%3CIsStrikeThrough%3Efalse%3C%2FIsStrikeThrough%3E%0A%20%20%3CIsUnderline%3Efalse%3C%2FIsUnderline%3E%0A%20%20%3COpacity%3E100%3C%2FOpacity%3E%0A%3C%2FCaption%3E"#CGI.escape(caption_xml.to_s)
    #puts encoded_xml

    xml = Builder::XmlMarkup.new( :indent => 2 )
    xml.instruct! :xml, :encoding => "utf-8"
    xml.CaptionPreview do |element|
      #maybe I missed something on how xml is supposed to be built; Cheezburger docs say <CaptionedImageUrl>http://api.cheezburger.com/xml/caption/[encoded caption data here]</CaptionedImageUrl>
      element.CaptionedImageUrl = "http://api.cheezburger.com/xml/caption/" + encoded_xml
    end
    post_xml(caption_preview_url,xml)
  end

  def caption_dimensions(caption_xml)
    caption_dimension_url = "http://api.cheezburger.com/xml/captions/dimensions"
    post_xml(caption_dimension_url,caption_xml)
  end

  def build_caption_xml(lol_caption_data)
    xml = Builder::XmlMarkup.new( :indent => 2 )
    xml.instruct! :xml, :encoding => "utf-8"
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