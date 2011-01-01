module Jsdoc
  class Return < ActiveRecord::Base
    belongs_to :function
  end
end
