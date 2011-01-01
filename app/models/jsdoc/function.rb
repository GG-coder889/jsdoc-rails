module Jsdoc
  class Function < ActiveRecord::Base
    belongs_to :symbol
    has_many :params
    has_many :returns
    has_many :requires
    has_many :throws
    has_many :sees, :as => 'see_for'
    has_many :examples, :as => 'example_for'
  end
end
