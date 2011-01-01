module Jsdoc
  class Example < ActiveRecord::Base
    belongs_to :example_for, :polymorphic => true
  end
end
