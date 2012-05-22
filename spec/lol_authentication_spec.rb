# -*- encoding : utf-8 -*-
require "lolruby/lol_authentication"
require "spec_helper"
require "nokogiri"

describe LolAuthentication do
  before :each do
    @lol_authentication = LolAuthentication.new
    @lol_authentication.api_key = YAML.load_file("lolapikey.yaml")["api_key"]
  end

  it "should create a new session" do
    response = @lol_authentication.new_authentication_session
    response.should have_tag("authenticationsessionresponse")
    response.should have_tag("authenticationsessionid")
    response.should have_tag("authenticationtoken")
    response.should have_tag("authorizationurl")
    puts response
  end

  it "should check to see if the user is validated" do
    new_session = @lol_authentication.new_authentication_session
    @session = Nokogiri::XML.parse(new_session)
    authentication_url = @session.xpath("//AuthenticationSessionId").inner_text
    response = @lol_authentication.validate_session(authentication_url)
    response[0]["AuthenticationStatus"].should eq("PENDING") #until I figure out how to auto logon to their site this will have to do
    puts response.inspect
  end

  it "should log the user out" do
    #until I figure out how to auto-login this will fail
    new_session = @lol_authentication.new_authentication_session
    @session = Nokogiri::XML.parse(new_session)
    authentication_url = @session.xpath("//AuthenticationSessionId").inner_text
    response = @lol_authentication.logout(authentication_url)
    true.should == false
  end
end
