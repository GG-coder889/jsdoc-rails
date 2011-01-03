require 'jsdoc'
require 'rails'
require 'action_controller'

module Jsdoc
  def self.table_name_prefix
    'jsdoc_'
  end

  class Engine < Rails::Engine
    @@mount_point = '/documentation'
    cattr_accessor :mount_point

    # We can add all of the public assets from our engine and make them
    # available to use.  This allows us to use javascripts, images, stylesheets
    # etc.
    initializer 'static assets' do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end
 

    rake_tasks do
      load 'jsdoc/railties/tasks.rake'
    end
  end
end
