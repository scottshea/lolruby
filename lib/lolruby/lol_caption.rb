require "lolruby/lol_base"
require "lolruby/version"
require "lolruby/lol_caption_data"

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
  end

end