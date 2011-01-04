module Jsdoc
  class Property < ActiveRecord::Base
    belongs_to :symbol

    has_many :borrowed_to_join, :class_name => 'Jsdoc::BorrowedProperty'
    has_many :borrowed_to, :through => :borrowed_to_join

    scope :private, where(:is_private => true)
    scope :public, where(:is_private => false)

    scope :for_symbol, lambda { |s| includes(:borrowed_to).where('symbol_id = :symbol_id OR jsdoc_borrowed_properties.borrowed_to_id = :symbol_id', :symbol_id => s.id) }
  end
end
