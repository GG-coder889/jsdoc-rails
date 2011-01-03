module Jsdoc
  class Symbol < ActiveRecord::Base
    belongs_to :constructor, :class_name => 'Jsdoc::Function'
    has_many :functions
    has_many :methods, :class_name => 'Jsdoc::Function', :conditions => ['function_type = ?', 'method']
    has_many :events, :class_name => 'Jsdoc::Function', :conditions => ['function_type = ?', 'event']
    has_many :examples
    has_many :properties
    has_many :public_properties, :class_name => 'Jsdoc::Property', :conditions => ['is_private = ?', false]
    has_many :public_functions,  :class_name => 'Jsdoc::Function', :conditions => ['is_private = ?', false]
    has_many :public_methods,    :class_name => 'Jsdoc::Function', :conditions => ['is_private = ? AND function_type = ?', false, 'method']
    has_many :public_events,     :class_name => 'Jsdoc::Function', :conditions => ['is_private = ? AND function_type = ?', false, 'event']
    has_many :private_properties, :class_name => 'Jsdoc::Property', :conditions => ['is_private = ?', true]
    has_many :private_functions,  :class_name => 'Jsdoc::Function', :conditions => ['is_private = ?', true]
    has_many :private_methods,    :class_name => 'Jsdoc::Function', :conditions => ['is_private = ? AND function_type = ?', true, 'method']
    has_many :private_events,     :class_name => 'Jsdoc::Function', :conditions => ['is_private = ? AND function_type = ?', true, 'event']

    has_many :borrowed_functions_join,  :foreign_key => 'borrowed_to_id', :class_name => 'Jsdoc::BorrowedFunction'
    has_many :borrowed_properties_join, :foreign_key => 'borrowed_to_id', :class_name => 'Jsdoc::BorrowedProperty'

    has_many :borrowed_functions,  :through => :borrowed_functions_join,  :source => :function
    has_many :borrowed_methods,    :through => :borrowed_functions_join,  :source => :function, :conditions => ['function_type = ?', 'method']
    has_many :borrowed_events,     :through => :borrowed_functions_join,  :source => :function, :conditions => ['function_type = ?', 'event']
    has_many :borrowed_properties, :through => :borrowed_properties_join, :source => :property

    has_many :borrowed_public_functions,  :through => :borrowed_functions_join,  :source => :function, :conditions => ['is_private = ?', false]
    has_many :borrowed_public_methods,    :through => :borrowed_functions_join,  :source => :function, :conditions => ['is_private = ? AND function_type = ?', false, 'method']
    has_many :borrowed_public_events,     :through => :borrowed_functions_join,  :source => :function, :conditions => ['is_private = ? AND function_type = ?', false, 'event']
    has_many :borrowed_public_properties, :through => :borrowed_properties_join, :source => :property, :conditions => ['is_private = ?', false]

    has_many :borrowed_private_functions,  :through => :borrowed_functions_join,  :source => :function, :conditions => ['is_private = ?', true]
    has_many :borrowed_private_methods,    :through => :borrowed_functions_join,  :source => :function, :conditions => ['is_private = ? AND function_type = ?', true, 'method']
    has_many :borrowed_private_events,     :through => :borrowed_functions_join,  :source => :function, :conditions => ['is_private = ? AND function_type = ?', true, 'event']
    has_many :borrowed_private_properties, :through => :borrowed_properties_join, :source => :property, :conditions => ['is_private = ?', true]

    has_many :children, :class_name => 'Jsdoc::Symbol', :foreign_key => :member_of, :primary_key => :alias
    has_many :subclasses, :class_name => 'Jsdoc::Symbol', :foreign_key => :extends, :primary_key => :alias

    belongs_to :superclass, :class_name => 'Jsdoc::Symbol', :foreign_key => :extends, :primary_key => :alias

    scope :namespaces, where(:symbol_type => 'namespace')
    scope :classes, where(:symbol_type => 'class')
    scope :functions, where(:symbol_type => 'function')


    def requires
      return [] if constructor.nil?
      return constructor.requires
    end

    def inheritance_tree
      branches = [self]
      while branches.last.superclass
        branches << branches.last.superclass
      end

      return branches
    end
  end
end
