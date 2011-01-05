Rails.application.routes.draw do
  scope Jsdoc::Engine.mount_point do
    root :to => 'jsdoc/documentation#index'
    match ':symbol_alias' => 'jsdoc/documentation#symbol', :symbol_alias => /[^\/]+/, :as => 'jsdoc_symbol'
    match 'source/:filename' => 'jsdoc/documentation#source', :filename => /.+/, :as => 'jsdoc_source'
    match 'raw/:filename' => 'jsdoc/documentation#raw_source', :filename => /.+/, :as => 'jsdoc_raw_source'
  end
end
