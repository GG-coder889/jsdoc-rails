$:.push File.expand_path("../lib", __FILE__)
require "jsdoc/version"

Gem::Specification.new do |s|
  s.name = "jsdoc-rails"

  s.authors     = ["Ryan Williams"]
  s.email       = ["jsdoc-rails@ryanwilliams.org"]

  s.version = Jsdoc::VERSION
  s.platform    = Gem::Platform::RUBY

  s.summary = "Rails 3 plugin to support JSDoc documentation"
  s.description = "This plugin includes a jsdoc-toolkit template and Rake task which generates a script to load all your documentation into the database. This allows you to create dynamic and easily searchable documentation."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/* | grep -v dummy`.split("\n")

  s.require_paths = ["lib"]

  s.add_dependency('rails', '>= 3.0.0')
end
