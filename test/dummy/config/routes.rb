Dummy::Application.routes.draw do
  mount Jsdoc::Engine => "/documentation", :as => "jsdoc"
end
