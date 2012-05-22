# -*- encoding : utf-8 -*-
module Lolruby
  class LolBase
    require "lolruby/version"
    require "rest-client"
    require "nokogiri"
    require "active_support/core_ext"

    attr_accessor :api_key

    def get_lol_xml(url,xpath)
      parsed_xml = Nokogiri::XML(RestClient.get url, :DeveloperKey => api_key).xpath(xpath)
      parsed_xml.map do |element|
        hash = Hash.new
        element.children.each do |child|
          hash.store(child.name, child.inner_text) if child.element?
        end
        hash
      end
    end

    def post_xml(url,xml, *auth_token)
      RestClient.post(url, xml, {:DeveloperKey => api_key, :content_type => "text/xml", :ClientID => "2165", :AuthenticationToken => auth_token})
    end
  end
end
