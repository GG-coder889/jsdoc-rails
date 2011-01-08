$:.push File.expand_path("../lib", __FILE__)
require "jsdoc/version"

Gem::Specification.new do |s|
  s.name = "jsdoc-rails"

  s.authors     = ["Ryan Williams"]
  s.email       = ["jsdoc-rails@ryanwilliams.org"]
  s.homepage    = "https://github.com/RyanWilliams/jsdoc-rails"
  s.license     = "MIT"


  s.version     = Jsdoc::VERSION
  s.platform    = Gem::Platform::RUBY

  s.summary     = "Rails 3 plugin to include JSDoc documentation on your site"
  s.description = "Uses an included copy of jsdoc-toolkit to parse your JavaScript documentation and then load it into your site's database. This means you can have far more dynamic documentation as you no longer need to rely on static HTML."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/* | grep -v dummy`.split("\n")

  s.require_paths = ["lib"]

  s.add_dependency('rails', '>= 3.0.0')
end
