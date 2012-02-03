class LolContentSubmission
  require "lolruby/version"
  require "lolruby/lol_picture_submission"
  require "rest-client"
  require "nokogiri"
  require "active_support/core_ext"
  require "builder"
  require "base64"

  attr_accessor :api_key

  def submit_picture
    picture_submission_url = "http://api.cheezburger.com/xml/picture"
    submission_response = RestClient.post picture_submission_url
  end

  def build_picture_xml(lol_picture_submission)
    encoded_image = Base64.encode64(open(lol_picture_submission.file_path).to_a.join)

    xml = Builder::XmlMarkup.new( :indent => 2 )
    xml.instruct! :xml, :encoding => "ASCII"
    xml.EncodedPicture do |element|
      element.Title lol_picture_submission.title
      element.Description lol_picture_submission.Description
      element.Attribution lol_picture_submission.Attribution
      element.AttributionUrl
      element.Base64EncodedImage encoded_image
    end
    puts xml.inspect
  end
end