module Jsdoc
  class Symbol < ActiveRecord::Base
    belongs_to :constructor, :class_name => 'Jsdoc::Function'
    has_many :functions
    has_many :examples
    has_many :properties

    has_many :borrowed_functions_join,  :foreign_key => 'borrowed_to_id', :class_name => 'Jsdoc::BorrowedFunction'
    has_many :borrowed_properties_join, :foreign_key => 'borrowed_to_id', :class_name => 'Jsdoc::BorrowedProperty'

    has_many :borrowed_functions,  :through => :borrowed_functions_join,  :source => :function
    has_many :borrowed_properties, :through => :borrowed_properties_join, :source => :property
  end
end
