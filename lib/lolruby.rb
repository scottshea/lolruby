require "lolruby/version"
require "active_support/inflector"
require "rest-client"
require "nokogiri"

require "lolruby/lol_content_retrieval"

module Lolruby

  class Utils

    def self.hello_world(api_key)
      #Tests to see that the system is up and responding
      hello_world_url = "http://api.cheezburger.com/xml/hai"
      cheezburger_response = RestClient.get hello_world_url, :DeveloperKey => api_key #
      cheezburger_xml = Nokogiri::XML(cheezburger_response)
      cheezburger_greeting = cheezburger_xml.xpath("//Greeting").inner_text
      if cheezburger_greeting == "O Hai!"
        return true
      else
        return false
      end
    end
  end

  class LolAuthenticate
    def self.authenticate
      authentication_url = "http://api.cheezburger.com/xml/authenticationsession"
      resource = RestClient::Resource.new authentication_url
      meow = resource.post :content_length => 0, header => {:DeveloperKey => "8afc3c96-de44-4d04-95c7-c726fc09a8a5"}
      return meow
    end
  end
end
