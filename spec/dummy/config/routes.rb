Rails.application.routes.draw do

  mount FileBrowser::Engine => "/file_browser"
end
