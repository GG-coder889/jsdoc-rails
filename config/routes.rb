Rails.application.routes.draw do
  scope Jsdoc::Engine.mount_point do
    root :to => 'jsdoc/documentation#index', :as => 'jsdoc_root'
    if Jsdoc::Engine.single_project
      scope :path => '/:version_number', :version_number => /[^\/]*/ do
        root  :to                => 'jsdoc/documentation#welcome',    :as => 'jsdoc_version_welcome'
        match ':symbol_alias'    => 'jsdoc/documentation#symbol',     :as => 'jsdoc_version_symbol',     :symbol_alias => /[^\/]+/
        match 'source/:filename' => 'jsdoc/documentation#source',     :as => 'jsdoc_version_source',     :filename     => /.+/
        match 'raw/:filename'    => 'jsdoc/documentation#raw_source', :as => 'jsdoc_version_raw_source', :filename     => /.+/
      end
    else
      scope :path => '/:project_slug/:version_number', :version_number => /[^\/]*/ do
        root  :to                => 'jsdoc/documentation#welcome',    :as => 'jsdoc_project_welcome'
        match ':symbol_alias'    => 'jsdoc/documentation#symbol',     :as => 'jsdoc_project_symbol',     :symbol_alias => /[^\/]+/
        match 'source/:filename' => 'jsdoc/documentation#source',     :as => 'jsdoc_project_source',     :filename     => /.+/
        match 'raw/:filename'    => 'jsdoc/documentation#raw_source', :as => 'jsdoc_project_raw_source', :filename     => /.+/
      end
    end
  end
end
