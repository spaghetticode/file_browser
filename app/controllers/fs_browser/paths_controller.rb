require_dependency "fs_browser/application_controller"

module FsBrowser
  class PathsController < ApplicationController
    respond_to :json

    def create
      @path = Path.new(params[:id])
      # respond_with @path
      render :json => @path
    end
  end
end
