module Jsdoc
  class Property < ActiveRecord::Base
    belongs_to :symbol
  end
end
