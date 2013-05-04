Rails.application.routes.draw do
  get 'demo/index'
  root to: 'demo#index'

  mount FileBrowser::Engine => "/file_browser"
end
