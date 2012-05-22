# -*- encoding : utf-8 -*-
require "lolruby/lol_base"

class LolContentRetrieval < Lolruby::LolBase

  def get_sites
    sites_url = "http://api.cheezburger.com/xml/site"
    sites_xpath = "//Site"
    get_lol_xml(sites_url, sites_xpath)
  end

  def get_categories
    category_url = "http://api.cheezburger.com/xml/category"
    category_xpath = "//CategoryDetail"
    get_lol_xml(category_url, category_xpath)
  end

  def get_random_picture(category,count = 1)
    # according to http://developer.cheezburger.com/forum/read/110428 the random apis are slow
    random_picture_url = "http://api.cheezburger.com/xml/category/#{category}/picture/random/#{count}"
    random_picture_xpath = "//Picture"
    get_lol_xml(random_picture_url, random_picture_xpath)
  end

  def get_random_lol(category,count = 1)
    # according to http://developer.cheezburger.com/forum/read/110428 the random apis are slow
    random_lol_url = "http://api.cheezburger.com/xml/category/#{category}/lol/random/#{count}"
    random_picture_xpath = "//Picture"
    get_lol_xml(random_lol_url, random_picture_xpath)
  end

  def get_featured_content_by_site(site_id,page,count)
    featured_content_url = site_id + "/featured/#{page}/#{count}"
    featured_content_xpath = "//Asset"
    get_lol_xml(featured_content_url, featured_content_xpath)
  end

  def get_favorites_by_user(username)
    #TODO: finish this once user is done
  end
end
