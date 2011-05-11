# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "twimage/version"

Gem::Specification.new do |s|
  s.name        = "twimage"
  s.version     = Twimage::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rob Cameron"]
  s.email       = ["cannikinn@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A gem for pulling images from various Twitter image services}
  s.description = %q{This gem will programatically grab images from a bunch of the most used Twitter image services}

  s.rubyforge_project = "twimage"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'nokogiri'
  s.add_dependency 'httparty'
end
