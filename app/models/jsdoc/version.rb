module Jsdoc
  class Version < ActiveRecord::Base
    belongs_to :project, :class_name => 'Jsdoc::Project'
    has_many :symbols, :class_name => 'Jsdoc::Symbol'
  end
end
