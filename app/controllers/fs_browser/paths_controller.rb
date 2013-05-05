require_dependency "fs_browser/application_controller"

module FsBrowser
  class PathsController < ApplicationController
    respond_to :json

    def create
      @path = Path.new(path_name)
      # respond_with @path
      render :json => @path
    end

    private

    def path_name
      Path.name_from_params(params)
    end
  end
end
