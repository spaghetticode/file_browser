require_dependency "file_browser/application_controller"

module FileBrowser
  class PathsController < ApplicationController
    respond_to :json

    def show
      @path = Path.new(path_name)
      respond_with @path
    end

    private

    def path_name
      Path.name_from_params(params)
    end
  end
end
