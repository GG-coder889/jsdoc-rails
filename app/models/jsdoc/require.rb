module Jsdoc
  class Require < ActiveRecord::Base
    belongs_to :function, :class_name => 'Jsdoc::Function'
  end
end
