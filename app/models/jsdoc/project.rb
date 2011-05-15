module Jsdoc
  class Project < ActiveRecord::Base
    has_many :versions, :class_name => 'Jsdoc::Version'
  end
end
