module Jsdoc
  class DocumentationController < ApplicationController
    layout 'jsdoc/documentation_wrapper'

    before_filter :get_project_and_version, :except => [:index]
    before_filter :get_root_symbols, :except => [:raw_source]

    def index
    end

    def welcome
    end

    def symbol
      if @version
        @symbol = @version.symbols.where(:alias => params[:symbol_alias]).first
      else
        @symbol = Jsdoc::Symbol.where(:alias => params[:symbol_alias]).first
      end
    end

    def source
      @filename = params[:filename]
      @source_code = get_source_code(@filename)
    end

    def raw_source
      @filename = params[:filename]
      render :text => get_source_code(@filename), :content_type => 'text/plain'
    end

    private

      def get_project_and_version

        if params[:project_slug].present? or Jsdoc::Engine.single_project
          if Jsdoc::Engine.single_project
            @project = Jsdoc::Project.first
          else
            @project = Jsdoc::Project.where(:slug => params[:project_slug]).first
          end

          raise "No project named : #{params[:project_slug]}" if @project.nil?
          # TODO render 404 if project not found

          if @project.present? and params[:version_number].present?
            @version = @project.versions.where(:version_number => params[:version_number]).first
            raise "No version named : #{params[:version_number]}" if @version.nil?
            # TODO render 404 if version not found
          end
        end
      end

      def get_source_code(filename)
        if Jsdoc::Engine.source_path[0..0] == '/'
          source_path = Jsdoc::Engine.source_path
        else
          source_root = File.expand_path(File.join(Rails.root, 'public', Jsdoc::Engine.source_path))
        end
        file_path = File.expand_path(File.join(source_root, filename))

        # Protect against kiddies trying to access other parts of the filesystem
        raise "Invalid path" unless file_path.start_with?(source_root)

        return File.open(file_path).read
      end

      def get_root_symbols
        if @version
          @root_symbols = @version.symbols.where(:member_of => nil)
        else
          @root_symbols = Jsdoc::Symbol.where(:member_of => nil)
        end

        if Jsdoc::Engine.no_global
          @root_symbols = @root_symbols.where('name != ?', '_global_')
        end
      end
  end
end
