Jsdoc::Engine.routes.draw do
  root :to => 'documentation#index', :as => 'jsdoc_root'
  if ::Rails.configuration.jsdoc.single_project
    scope :path => '/:version_number', :version_number => /[^\/]*/ do
      root  :to                => 'documentation#welcome',    :as => 'version_welcome'
      match ':symbol_alias'    => 'documentation#symbol',     :as => 'version_symbol',     :symbol_alias => /[^\/]+/
      match 'source/:filename' => 'documentation#source',     :as => 'version_source',     :filename     => /.+/
      match 'raw/:filename'    => 'documentation#raw_source', :as => 'version_raw_source', :filename     => /.+/
    end
  else
    scope :path => '/:project_slug/:version_number', :version_number => /[^\/]*/ do
      root  :to                => 'documentation#welcome',    :as => 'project_welcome'
      match ':symbol_alias'    => 'documentation#symbol',     :as => 'project_symbol',     :symbol_alias => /[^\/]+/
      match 'source/:filename' => 'documentation#source',     :as => 'project_source',     :filename     => /.+/
      match 'raw/:filename'    => 'documentation#raw_source', :as => 'project_raw_source', :filename     => /.+/
    end
  end
end
