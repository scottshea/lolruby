class LolContentRetrieval
  require "lolruby/version"
  require "rest-client"
  require "nokogiri"
  require "active_support/core_ext"

  attr_accessor :api_key

  def get_sites
    sites_url = "http://api.cheezburger.com/xml/site"
    sites_response = RestClient.get sites_url, :DeveloperKey => api_key
    sites_raw_xml = Nokogiri::XML(sites_response)
    site_hash_array = Array.new
    sites_parsed_xml = sites_raw_xml.xpath("//Site")
    sites_parsed_xml.each do |site|
      site_hash = Hash.new
      site.children.each do |child|
        if child.element?
          site_hash.store(child.name, child.inner_text)
        end
      end
      site_hash_array << site_hash
    end
    return site_hash_array
  end

  def get_categories
    category_url = "http://api.cheezburger.com/xml/category"
    category_response = RestClient.get category_url, :DeveloperKey => api_key
    category_xml = Nokogiri::XML(category_response)
    cheezburger_categories_xml = category_xml.xpath("//CategoryName")
    cheezburger_categories = Array.new
    cheezburger_categories_xml.each do |category|
      cheezburger_categories << category.inner_text
    end
    return cheezburger_categories
  end

  def get_random_lol(category,count = 1)
    random_lol_url = "http://api.cheezburger.com/xml/category/#{category}/lol/random/#{count}"
    random_lol_response = RestClient.get random_lol_url, :DeveloperKey => api_key
    random_lol_xml = Nokogiri::XML(random_lol_response)
    lol_hash_array =  Array.new
    lol_xml = random_lol_xml.xpath("//Picture")
    lol_xml.each do |individual_lol|
      lol_hash = Hash.new
      individual_lol.children.each do |child|
        if child.element?
          lol_hash.store(child.name, child.inner_text)
        end
      end
      lol_hash_array << lol_hash
    end
    return lol_hash_array
  end

  def get_random_picture(category,count = 1)
    random_picture_url = "http://api.cheezburger.com/xml/category/#{category}/picture/random/#{count}"
    random_picture_response = RestClient.get random_picture_url, :DeveloperKey => api_key
    random_picture_xml = Nokogiri::XML(random_picture_response)
    picture_hash_array =  Array.new
    picture_xml = random_picture_xml.xpath("//Picture")
    picture_xml.each do |individual_lol|
      picture_hash = Hash.new
      individual_lol.children.each do |child|
        if child.element?
          picture_hash.store(child.name, child.inner_text)
        end
      end
      picture_hash_array << picture_hash
    end
    return picture_hash_array
  end
end