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

    has_many :children, :class_name => 'Jsdoc::Symbol', :foreign_key => :member_of, :primary_key => :alias

    scope :namespaces, where(:symbol_type => 'namespace')
    scope :classes, where(:symbol_type => 'class')
    scope :functions, where(:symbol_type => 'function')

  end
end
