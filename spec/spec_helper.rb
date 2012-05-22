# -*- encoding : utf-8 -*-
require "rspec"
require "yaml"
require "rspec-hpricot-matchers"

RSpec.configure do |config|
  config.include(HpricotSpec::Matchers)
end
