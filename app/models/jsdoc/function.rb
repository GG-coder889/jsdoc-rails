module Jsdoc
  class Function < ActiveRecord::Base
    belongs_to :symbol
    has_many :params
    has_many :returns
    has_many :requires
    has_many :throws
    has_many :sees, :as => 'see_for'
    has_many :examples, :as => 'example_for'

    has_many :borrowed_to_join, :class_name => 'Jsdoc::BorrowedFunction'
    has_many :borrowed_to, :through => :borrowed_to_join

    scope :private, where(:is_private => true)
    scope :public, where(:is_private => false)
    scope :method_types, where(:function_type => 'method')
    scope :event_types, where(:function_type => 'event')

    scope :for_symbol, lambda { |s| includes(:borrowed_to).where('symbol_id = :symbol_id OR (jsdoc_borrowed_functions.borrowed_to_id = :symbol_id)', :symbol_id => s.id) }
  end
end
