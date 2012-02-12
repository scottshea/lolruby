require "lolruby/lol_base"

class LolContentRetrieval < Lolruby::LolBase

  def get_sites
    sites_url = "http://api.cheezburger.com/xml/site"
    sites_xpath = "//Site"
    site_hash_array = get_lol_xml(sites_url, sites_xpath)

    return site_hash_array
  end

  def get_categories
    category_url = "http://api.cheezburger.com/xml/category"
    category_xpath = "//CategoryDetail"
    cheezburger_categories = get_lol_xml(category_url, category_xpath)

    return cheezburger_categories
  end

  def get_random_picture(category,count = 1)
    random_picture_url = "http://api.cheezburger.com/xml/category/#{category}/picture/random/#{count}"
    random_picture_xpath = "//Picture"
    picture_hash_array = get_lol_xml(random_picture_url, random_picture_xpath)

    return picture_hash_array
  end

  def get_random_lol(category,count = 1)
    random_lol_url = "http://api.cheezburger.com/xml/category/#{category}/lol/random/#{count}"
    random_picture_xpath = "//Picture"
    lol_hash_array = get_lol_xml(random_lol_url, random_picture_xpath)

    return lol_hash_array
  end

  def get_featured_content_by_site(site_id,page,count)
    featured_content_url = site_id + "/featured/#{page}/#{count}"
    featured_content_xpath = "//Asset"
    assets_array = get_lol_xml(featured_content_url, featured_content_xpath)

    return assets_array
  end

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

  def get_favorites_by_user(username)
    #TODO: finish this once user is done
  end
end
