module Jsdoc
  class Symbol < ActiveRecord::Base
    belongs_to :project_version, :class_name => 'Jsdoc::Version'
    has_one :project, :through => :project_version

    belongs_to :constructor, :class_name => 'Jsdoc::Function'
    has_many :examples, :as => 'example_for', :dependent => :destroy

    has_many :own_functions, :class_name => 'Jsdoc::Function', :dependent => :destroy
    has_many :own_properties, :class_name => 'Jsdoc::Property', :dependent => :destroy

    has_many :borrowed_functions_join,  :foreign_key => 'borrowed_to_id', :class_name => 'Jsdoc::BorrowedFunction', :dependent => :destroy
    has_many :borrowed_properties_join, :foreign_key => 'borrowed_to_id', :class_name => 'Jsdoc::BorrowedProperty', :dependent => :destroy

    has_many :borrowed_functions, :through => :borrowed_functions_join,  :source => :function, :dependent => :destroy
    has_many :borrowed_properties, :through => :borrowed_properties_join, :source => :property, :dependent => :destroy

    has_many :children, :class_name => 'Jsdoc::Symbol', :foreign_key => :member_of, :primary_key => :alias, :conditions => proc {"version_id = #{version_id}"}
    has_many :subclasses, :class_name => 'Jsdoc::Symbol', :foreign_key => :extends, :primary_key => :alias, :conditions => proc {"version_id = #{version_id}"}

    belongs_to :superclass, :class_name => 'Jsdoc::Symbol', :foreign_key => :extends, :primary_key => :alias, :conditions => proc {"version_id = #{version_id}"}

    scope :namespaces, where(:symbol_type => 'namespace')
    scope :classes, where(:symbol_type => 'class')
    scope :functions, where(:symbol_type => 'function')

    before_save :expire_cache

    def functions
      return Jsdoc::Function.for_symbol(self)
    end

    def properties
      return Jsdoc::Property.for_symbol(self)
    end

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

    def public_members?
      return true if properties.public.present?
      return true if functions.public.present?
      return false
    end

    def private_members?
      return true if properties.private.present?
      return true if functions.private.present?
      return false
    end

    def expire_cache
      ActionController::Base.new.expire_fragment("symbol_#{self.version_id_was}_#{self.alias_was}")
      ActionController::Base.new.expire_fragment("symbol_#{self.version_id}_#{self.alias}")

      if self.name_changed? or self.alias_changed? or self.version_id_changed? or self.project_id_changed?
        ActionController::Base.new.expire_fragment("aside")
      end

      true
    end
  end
end
