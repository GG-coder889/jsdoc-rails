module Jsdoc
  class BorrowedFunction < ActiveRecord::Base
    belongs_to :borrowed_to, :class_name => 'Jsdoc::Symbol'
    belongs_to :borrowed_from, :class_name => 'Jsdoc::Symbol'
    belongs_to :function
  end
end
