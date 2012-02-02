require "lolruby/lol_content_retrieval"
require "rspec"
require "yaml"

describe LolContentRetrieval do
  it "gets the lol categories" do
    lol_categories = LolContentRetrieval.new
    lol_categories.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
    lol_categories.get_categories.should include("Cats")
  end

  it "gets a random lol" do
    lol_random_lol = LolContentRetrieval.new
    lol_random_lol.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
    returned_lol = lol_random_lol.get_random_lol("Cats")[0]
    returned_lol.should include("LolId")
  end

  it "gets 10 random lols" do
    lol_random_lol = LolContentRetrieval.new
    lol_random_lol.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
    lol_random_lol.get_random_lol("Cats",10).count.should == 10
  end

  it "gets a random picture" do
    lol_random_picture = LolContentRetrieval.new
    lol_random_picture.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
    returned_picture = lol_random_picture.get_random_picture("Cats")[0]
    returned_picture.should include("PictureId")
  end

  it "gets 7 random pictures" do
    lol_random_picture = LolContentRetrieval.new
    lol_random_picture.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
    lol_random_picture.get_random_picture("Cats",7).count.should == 7
  end

  it "gets an array of sites" do
    lol_sites = LolContentRetrieval.new
    lol_sites.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
    lol_sites.get_sites[0].keys.should include("SiteId")
  end

  it "gets a hash of featured content for site" do
    lol_featured_content = LolContentRetrieval.new
    lol_featured_content.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
    sites = lol_featured_content.get_sites
    lol_featured_content.get_featured_content_by_site(sites[1]["SiteId"],1,3)[1].keys.should include("ContentUrl")
  end
end