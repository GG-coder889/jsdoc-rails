$:.push File.expand_path("../lib", __FILE__)
require "jsdoc/version"

Gem::Specification.new do |s|
  s.name = "jsdoc-rails"

  s.authors     = ["Ryan Williams"]
  s.email       = ["jsdoc-rails@ryanwilliams.org"]
  s.homepage    = "https://github.com/RyanWilliams/jsdoc-rails"
  s.license     = "MIT"

  s.version     = Jsdoc::ENGINE_VERSION
  s.platform    = Gem::Platform::RUBY

  s.summary     = "Rails 3.1 Engine to include JSDoc documentation on your application"
  s.description = "Uses an included copy of jsdoc-toolkit to parse your JavaScript documentation and then load it into your site's database. This means you can have far more dynamic documentation as you no longer need to rely on static HTML."

  s.files       = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files  = Dir["test/**/*"]

  s.add_dependency('rails', '>= 3.1.0')
end
