module Jsdoc
  class Param < ActiveRecord::Base
    belongs_to :function
  end
end
