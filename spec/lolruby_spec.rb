# -*- encoding : utf-8 -*-
require "lolruby"
require "spec_helper"

describe Lolruby::Utils do
  it "tests the cheezburger response" do
    dev_key = YAML.load_file("lolapikey.yaml")["api_key"]
    Lolruby::Utils.hello_world(dev_key).should eql(true)
  end
end
