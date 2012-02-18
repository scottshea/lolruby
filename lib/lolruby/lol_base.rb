module Lolruby
  class LolBase
    require "lolruby/version"
    require "rest-client"
    require "nokogiri"
    require "active_support/core_ext"

    attr_accessor :api_key

    def get_lol_xml(url,xpath)
      #puts "Passed xpath: #{xpath}; url: #{url}"
      parsed_xml = Nokogiri::XML(RestClient.get url, :DeveloperKey => api_key).xpath(xpath)
      #puts "XML: #{parsed_xml.inspect}"
      parsed_xml.map do |element|
        hash = Hash.new
        #puts "Element: #{element.class}; #{element.inspect}"
        element.children.each do |child|
          #puts "Child 1: #{child.class}; #{child.element?.inspect}; #{child.inspect}"
          if child.element?
            #puts "Child: #{child.name}; #{child.inner_text}"
            hash.store(child.name, child.inner_text)
          end
        end
        hash
      end
    end

    def post_xml(url,xml)
      RestClient.post(url, xml, {:DeveloperKey => api_key, :content_type => "text/xml", :ClientID => "2165"})
    end
  end
end
