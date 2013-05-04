require_dependency "file_browser/application_controller"

module FileBrowser
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
