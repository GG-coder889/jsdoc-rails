require 'jsdoc/configuration'

module Jsdoc
  class Engine < Rails::Engine
    config.jsdoc = Jsdoc::Configuration.new

    isolate_namespace Jsdoc
  end
end
