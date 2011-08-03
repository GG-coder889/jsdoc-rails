module Jsdoc
  class Configuration
    attr_accessor :source_path, :single_project, :no_global

    def initialize
      @source_path = 'jsdoc/source'
      @single_project = true
      @no_global = true
    end
  end
end
