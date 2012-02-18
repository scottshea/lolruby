# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lolruby/version"

Gem::Specification.new do |s|
  s.name        = "lolruby"
  s.version     = Lolruby::VERSION
  s.authors     = ["Scott Shea"]
  s.email       = ["scott.j.shea@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{a gem to encapsulate the icanhascheezburger api}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "lolruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-hpricot-matchers"

  s.add_dependency "activesupport"
  s.add_dependency "rest-client"
  s.add_dependency "nokogiri"
  s.add_dependency "builder"
  # s.add_runtime_dependency "rest-client"
end
