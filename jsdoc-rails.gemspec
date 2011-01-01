Gem::Specification.new do |s|
  s.name = "jsdoc-rails"
  s.summary = "Rails 3 plugin to support JSDoc documentation"
  s.description = "This plugin includes a jsdoc-toolkit template and Rake task which generates a script to load all your documentation into the database. This allows you to create dynamic and easily searchable documentation."
  s.files = Dir["lib/**/*"] + Dir["app/**/*"] +Dir["config/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.version = "0.0.1"
end
