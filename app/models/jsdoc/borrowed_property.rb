module Jsdoc
  class BorrowedProperty < ActiveRecord::Base
    belongs_to :borrowed_to, :class_name => 'Jsdoc::Symbol'
    belongs_to :borrowed_from, :class_name => 'Jsdoc::Symbol'
    belongs_to :property
  end
end
