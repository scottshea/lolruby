# -*- encoding : utf-8 -*-
require "lolruby/lol_content_retrieval"
require "spec_helper"

describe LolContentRetrieval do
  before :each do
    @lol_content = LolContentRetrieval.new
    @lol_content.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
  end

  it "gets the lol categories" do
    @lol_content.get_categories[0].keys.should include("CategoryName")
  end

  it "gets a random lol" do
    @lol_content.get_random_lol("Cats")[0].should include("LolId")
  end

  it "gets 10 random lols" do
    @lol_content.get_random_lol("Cats",3).count.should == 3
  end

  it "gets a random picture" do
    @lol_content.get_random_picture("Cats")[0].should include("PictureId")
  end

  it "gets 7 random pictures" do
    @lol_content.get_random_picture("Cats",2).count.should == 2
  end

  it "gets an array of sites" do
    @lol_content.get_sites[0].keys.should include("SiteId")
  end

  it "gets a hash of featured content for site" do
    sites = @lol_content.get_sites
    @lol_content.get_featured_content_by_site(sites[1]["SiteId"],1,3)[1].keys.should include("ContentUrl")
  end
end
