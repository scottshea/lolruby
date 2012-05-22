# -*- encoding : utf-8 -*-
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
  end

  def caption_text_style
    #they only support the three items now and there is no REST call to make to get the list
    Array["outline","dropshadow","none"]
  end

  def caption_preview(caption_xml)
    caption_preview_url = "http://api.cheezburger.com/xml/captions/preview"
    encoded_xml = "?%3C%3Fxml%20version%3D%221.0%22%20encoding%3D%22utf-8%22%3F%3E%0A%3CCaptionData%3E%0A%20%20%3COriginalImageUrl%3Ehttp%3A%2F%2Fimages.cheezburger.com%2Fimagestore%2F2008%2F12%2F14%2Fb8e71e41-c287-4ed3-af39-0ff4cdf4f817.jpg%3C%2FOriginalImageUrl%3E%0A%20%20%3CCaptions%3E%0A%20%20%20%20%3CCaption%3E%0A%20%20%20%20%20%20%3CText%3EI%20CAN%20HAS%20CAPTION%2C%20PLZ%3F%3C%2FText%3E%0A%20%20%20%20%20%20%3CFontFamily%3EImpact%3C%2FFontFamily%3E%0A%20%20%20%20%20%20%3CFontSize%3E40%3C%2FFontSize%3E%0A%20%20%20%20%20%20%3CFontColor%3Ewhite%3C%2FFontColor%3E%0A%20%20%20%20%20%20%3CXPosition%3E90%3C%2FXPosition%3E%0A%20%20%20%20%20%20%3CYPosition%3E25%3C%2FYPosition%3E%0A%20%20%20%20%20%20%3CIsBold%3Efalse%3C%2FIsBold%3E%0A%20%20%20%20%20%20%3CTextStyle%3Eoutline%3C%2FTextStyle%3E%0A%20%20%20%20%20%20%3CIsItalic%3Efalse%3C%2FIsItalic%3E%0A%20%20%20%20%20%20%3CIsStrikeThrough%3Efalse%3C%2FIsStrikeThrough%3E%0A%20%20%20%20%20%20%3CIsUnderLine%3Efalse%3C%2FIsUnderLine%3E%0A%20%20%20%20%20%20%3COpacity%3E100%3C%2FOpacity%3E%0A%20%20%20%20%3C%2FCaption%3E%0A%20%20%20%20%3CCaption%3E%0A%20%20%20%20%20%20%3CText%3EYES%2C%20U%20CAN%20HAS%20CAPTION!%3C%2FText%3E%0A%20%20%20%20%20%20%3CFontFamily%3EImpact%3C%2FFontFamily%3E%0A%20%20%20%20%20%20%3CFontSize%3E40%3C%2FFontSize%3E%0A%20%20%20%20%20%20%3CFontColor%3Ewhite%3C%2FFontColor%3E%0A%20%20%20%20%20%20%3CXPosition%3E80%3C%2FXPosition%3E%0A%20%20%20%20%20%20%3CYPosition%3E205%3C%2FYPosition%3E%0A%20%20%20%20%20%20%3CIsBold%3Efalse%3C%2FIsBold%3E%0A%20%20%20%20%20%20%3CTextStyle%3Eoutline%3C%2FTextStyle%3E%0A%20%20%20%20%20%20%3CIsItalic%3Efalse%3C%2FIsItalic%3E%0A%20%20%20%20%20%20%3CIsStrikeThrough%3Efalse%3C%2FIsStrikeThrough%3E%0A%20%20%20%20%20%20%3CIsUnderLine%3Efalse%3C%2FIsUnderLine%3E%0A%20%20%20%20%20%20%3COpacity%3E100%3C%2FOpacity%3E%0A%20%20%20%20%3C%2FCaption%3E%0A%20%20%20%20%3CCaption%3E%0A%20%20%20%20%20%20%3CText%3ETextStyle%3A%20outline%3C%2FText%3E%0A%20%20%20%20%20%20%3CFontFamily%3EImpact%3C%2FFontFamily%3E%0A%20%20%20%20%20%20%3CFontSize%3E20%3C%2FFontSize%3E%0A%20%20%20%20%20%20%3CFontColor%3Ewhite%3C%2FFontColor%3E%0A%20%20%20%20%20%20%3CXPosition%3E10%3C%2FXPosition%3E%0A%20%20%20%20%20%20%3CYPosition%3E270%3C%2FYPosition%3E%0A%20%20%20%20%20%20%3CIsBold%3Efalse%3C%2FIsBold%3E%0A%20%20%20%20%20%20%3CTextStyle%3Eoutline%3C%2FTextStyle%3E%0A%20%20%20%20%20%20%3CIsItalic%3Efalse%3C%2FIsItalic%3E%0A%20%20%20%20%20%20%3CIsStrikeThrough%3Efalse%3C%2FIsStrikeThrough%3E%0A%20%20%20%20%20%20%3CIsUnderLine%3Efalse%3C%2FIsUnderLine%3E%0A%20%20%20%20%20%20%3COpacity%3E100%3C%2FOpacity%3E%0A%20%20%20%20%3C%2FCaption%3E%0A%20%20%20%20%3CCaption%3E%0A%20%20%20%20%20%20%3CText%3ETextStyle%3A%20none%3C%2FText%3E%0A%20%20%20%20%20%20%3CFontFamily%3EImpact%3C%2FFontFamily%3E%0A%20%20%20%20%20%20%3CFontSize%3E20%3C%2FFontSize%3E%0A%20%20%20%20%20%20%3CFontColor%3Ewhite%3C%2FFontColor%3E%0A%20%20%20%20%20%20%3CXPosition%3E160%3C%2FXPosition%3E%0A%20%20%20%20%20%20%3CYPosition%3E270%3C%2FYPosition%3E%0A%20%20%20%20%20%20%3CIsBold%3Efalse%3C%2FIsBold%3E%0A%20%20%20%20%20%20%3CTextStyle%3Enone%3C%2FTextStyle%3E%0A%20%20%20%20%20%20%3CIsItalic%3Efalse%3C%2FIsItalic%3E%0A%20%20%20%20%20%20%3CIsStrikeThrough%3Efalse%3C%2FIsStrikeThrough%3E%0A%20%20%20%20%20%20%3CIsUnderLine%3Efalse%3C%2FIsUnderLine%3E%0A%20%20%20%20%20%20%3COpacity%3E100%3C%2FOpacity%3E%0A%20%20%20%20%3C%2FCaption%3E%0A%20%20%20%20%3CCaption%3E%0A%20%20%20%20%20%20%3CText%3ETextStyle%3A%20dropshadow%3C%2FText%3E%0A%20%20%20%20%20%20%3CFontFamily%3EImpact%3C%2FFontFamily%3E%0A%20%20%20%20%20%20%3CFontSize%3E20%3C%2FFontSize%3E%0A%20%20%20%20%20%20%3CFontColor%3Ewhite%3C%2FFontColor%3E%0A%20%20%20%20%20%20%3CXPosition%3E295%3C%2FXPosition%3E%0A%20%20%20%20%20%20%3CYPosition%3E270%3C%2FYPosition%3E%0A%20%20%20%20%20%20%3CIsBold%3Efalse%3C%2FIsBold%3E%0A%20%20%20%20%20%20%3CTextStyle%3Edropshadow%3C%2FTextStyle%3E%0A%20%20%20%20%20%20%3CIsItalic%3Efalse%3C%2FIsItalic%3E%0A%20%20%20%20%20%20%3CIsStrikeThrough%3Efalse%3C%2FIsStrikeThrough%3E%0A%20%20%20%20%20%20%3CIsUnderLine%3Efalse%3C%2FIsUnderLine%3E%0A%20%20%20%20%20%20%3COpacity%3E100%3C%2FOpacity%3E%0A%20%20%20%20%3C%2FCaption%3E%0A%20%20%20%20%3CCaption%3E%0A%20%20%20%20%20%20%3CText%3EOpacity%3A%2025%3C%2FText%3E%0A%20%20%20%20%20%20%3CFontFamily%3EImpact%3C%2FFontFamily%3E%0A%20%20%20%20%20%20%3CFontSize%3E20%3C%2FFontSize%3E%0A%20%20%20%20%20%20%3CFontColor%3Ewhite%3C%2FFontColor%3E%0A%20%20%20%20%20%20%3CXPosition%3E10%3C%2FXPosition%3E%0A%20%20%20%20%20%20%3CYPosition%3E295%3C%2FYPosition%3E%0A%20%20%20%20%20%20%3CIsBold%3Efalse%3C%2FIsBold%3E%0A%20%20%20%20%20%20%3CTextStyle%3Eoutline%3C%2FTextStyle%3E%0A%20%20%20%20%20%20%3CIsItalic%3Efalse%3C%2FIsItalic%3E%0A%20%20%20%20%20%20%3CIsStrikeThrough%3Efalse%3C%2FIsStrikeThrough%3E%0A%20%20%20%20%20%20%3CIsUnderLine%3Efalse%3C%2FIsUnderLine%3E%0A%20%20%20%20%20%20%3COpacity%3E25%3C%2FOpacity%3E%0A%20%20%20%20%3C%2FCaption%3E%0A%20%20%20%20%3CCaption%3E%0A%20%20%20%20%20%20%3CText%3EFontFamily%3A%20Verdana%3C%2FText%3E%0A%20%20%20%20%20%20%3CFontFamily%3EVerdana%3C%2FFontFamily%3E%0A%20%20%20%20%20%20%3CFontSize%3E20%3C%2FFontSize%3E%0A%20%20%20%20%20%20%3CFontColor%3Ewhite%3C%2FFontColor%3E%0A%20%20%20%20%20%20%3CXPosition%3E105%3C%2FXPosition%3E%0A%20%20%20%20%20%20%3CYPosition%3E295%3C%2FYPosition%3E%0A%20%20%20%20%20%20%3CIsBold%3Etrue%3C%2FIsBold%3E%0A%20%20%20%20%20%20%3CTextStyle%3Eoutline%3C%2FTextStyle%3E%0A%20%20%20%20%20%20%3CIsItalic%3Efalse%3C%2FIsItalic%3E%0A%20%20%20%20%20%20%3CIsStrikeThrough%3Efalse%3C%2FIsStrikeThrough%3E%0A%20%20%20%20%20%20%3CIsUnderLine%3Efalse%3C%2FIsUnderLine%3E%0A%20%20%20%20%20%20%3COpacity%3E100%3C%2FOpacity%3E%0A%20%20%20%20%3C%2FCaption%3E%0A%20%20%20%20%3CCaption%3E%0A%20%20%20%20%20%20%3CText%3EFontColor%3A%20Yellow%3C%2FText%3E%0A%20%20%20%20%20%20%3CFontFamily%3EImpact%3C%2FFontFamily%3E%0A%20%20%20%20%20%20%3CFontSize%3E20%3C%2FFontSize%3E%0A%20%20%20%20%20%20%3CFontColor%3EYellow%3C%2FFontColor%3E%0A%20%20%20%20%20%20%3CXPosition%3E345%3C%2FXPosition%3E%0A%20%20%20%20%20%20%3CYPosition%3E295%3C%2FYPosition%3E%0A%20%20%20%20%20%20%3CIsBold%3Efalse%3C%2FIsBold%3E%0A%20%20%20%20%20%20%3CTextStyle%3Eoutline%3C%2FTextStyle%3E%0A%20%20%20%20%20%20%3CIsItalic%3Efalse%3C%2FIsItalic%3E%0A%20%20%20%20%20%20%3CIsStrikeThrough%3Efalse%3C%2FIsStrikeThrough%3E%0A%20%20%20%20%20%20%3CIsUnderLine%3Efalse%3C%2FIsUnderLine%3E%0A%20%20%20%20%20%20%3COpacity%3E100%3C%2FOpacity%3E%0A%20%20%20%20%3C%2FCaption%3E%0A%20%20%3C%2FCaptions%3E%0A%3C%2FCaptionData%3E"#CGI.escape(caption_xml.to_s)

    xml = Builder::XmlMarkup.new( :indent => 2 )
    xml.instruct! :xml, :encoding => "utf-8"
    xml.CaptionPreview do |element|
      #maybe I missed something on how xml is supposed to be built; Cheezburger docs say <CaptionedImageUrl>http://api.cheezburger.com/xml/caption/[encoded caption data here]</CaptionedImageUrl>
      element.CaptionedImageUrl = "http://api.cheezburger.com/xml/caption/" + encoded_xml
    end
    post_xml(caption_preview_url,xml)
  end

  def caption_preview_hack(lol_caption_data)
    #Is this a hack? Oh yes, it should make you cringe. I could not figure out the preview api and resorted to
    #how I did it the last time. I cannot even get the <bleep>ing encoding right
    caption_preview_url = "http://cheezburger.com/caption/previewcaption.ashx?"
    caption_preview_encoded_data = "%3c%3fxml+version%3d%221.0%22+encoding%3d%22utf-8%22%3f%3e%3cCaptionData%3e"  +
        "%3cOriginalImageUrl%3e"  + lol_caption_data.original_image    + "%3c%2fOriginalImageUrl%3e%3cCaptions%3e" +
        "%3cCaption%3e%3cText%3e" + lol_caption_data.text              + "%3c%2fText%3e"                           +
        "%3CFontFamily%3E"        + lol_caption_data.font_family       + "%3C%2FFontFamily%3E"                     +
        "%3cFontSize%3e"          + lol_caption_data.font_size.to_s    + "%3c%2fFontSize%3e"                       +
        "%3CFontColor%3E"         + lol_caption_data.font_color        + "%3C%2FFontColor%3E"                      +
        "%3cXPosition%3e"         + lol_caption_data.x_position.to_s   + "%3c%2fXPosition%3e"                      +
        "%3cYPosition%3e"         + lol_caption_data.y_position.to_s   + "%3c%2fYPosition%3e"                      +
        "%3CIsBold%3E"            + lol_caption_data.is_bold           + "%3C%2FIsBold%3E"                         +
        "%3CTextStyle%3E"         + lol_caption_data.text_style        + "%3C%2FTextStyle%3E"                      +
        "%3CIsItalic%3E"          + lol_caption_data.is_italic         + "%3C%2FIsItalic%3E"                       +
        "%3CIsStrikeThrough%3E"   + lol_caption_data.is_strikethrough  + "%3C%2FIsStrikeThrough%3E"                +
        "%3CIsUnderLine%3E"       + lol_caption_data.is_underline      + "%3C%2FIsUnderLine%3E"                    +
        "%3COpacity%3E"           + lol_caption_data.font_opacity.to_s + "%3C%2FOpacity%3E"                        +
        "%3c%2fCaption%3e%3c%2fCaptions%3e%3c%2fCaptionData%3e"
    caption_preview_url + caption_preview_encoded_data
  end

  def caption_dimensions(caption_xml)
    caption_dimension_url = "http://api.cheezburger.com/xml/captions/dimensions"
    post_xml(caption_dimension_url,caption_xml)
  end

  def build_caption_xml(lol_caption_data)
    xml = Builder::XmlMarkup.new( :indent => 2 )
    xml.instruct! :xml, :encoding => "utf-8"
    #xml.CaptionData do
    #  xml.OriginalImageUrl lol_caption_data.original_image
    #  xml.Captions do
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
    #  end
    #end
    return xml
  end
end
