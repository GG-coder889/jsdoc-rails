module Jsdoc
  class DocumentationController < ApplicationController
    layout 'jsdoc/documentation_wrapper'

    def index
    end

    def symbol
      @symbol = Jsdoc::Symbol.where(:alias => params[:symbol_alias]).first
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
  end
end
