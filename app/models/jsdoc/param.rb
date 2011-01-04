module Jsdoc
  class Param < ActiveRecord::Base
    belongs_to :function

    default_scope order('"order"')
  end
end
