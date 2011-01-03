Rails.application.routes.draw do
  scope Jsdoc::Engine.mount_point do
    root :to => 'jsdoc/documentation#index'
  end
end
