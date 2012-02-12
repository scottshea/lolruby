require "lolruby/lol_base"
require "lolruby/version"
require "lolruby/lol_picture_submission"
require "builder"
require "base64"

class LolContentSubmission < Lolruby::LolBase


  def submit_picture
    picture_submission_url = "http://api.cheezburger.com/xml/picture"
    submission_response = RestClient.post(picture_submission_url, xml_data)


    #submission_response = RestClient.post picture_submission_url, :DeveloperKey => api_key,
  end

  def build_picture_xml(lol_picture_submission)
    encoded_image = Base64.encode64(open(lol_picture_submission.file_path).to_a.join)

    xml = Builder::XmlMarkup.new( :indent => 2 )
    xml.instruct! :xml, :encoding => "ASCII"
    xml.EncodedPicture do |element|
      element.Title lol_picture_submission.title
      element.Description lol_picture_submission.description
      element.Attribution lol_picture_submission.attribution
      element.AttributionUrl
      element.Base64EncodedImage encoded_image
    end
    puts xml.inspect
  end
end