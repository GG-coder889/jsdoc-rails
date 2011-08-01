module Jsdoc
  class Engine < Rails::Engine
    isolate_namespace Jsdoc

    @@source_path = 'jsdoc/source'
    cattr_accessor :source_path
    @@single_project = true
    cattr_accessor :single_project
    @@no_global = true
    cattr_accessor :no_global
  end
end
