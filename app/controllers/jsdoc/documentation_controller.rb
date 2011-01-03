module Jsdoc
  class DocumentationController < ApplicationController
    def index
    end

    def symbol
      @symbol = Jsdoc::Symbol.where(:alias => params[:symbol_alias]).first
    end

    def source
      render :text => params.inspect
    end
  end
end
