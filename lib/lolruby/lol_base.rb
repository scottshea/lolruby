module Lolruby
  class LolBase
    require "lolruby/version"
    require "rest-client"
    require "nokogiri"
    require "active_support/core_ext"

    attr_accessor :api_key
  end
end
