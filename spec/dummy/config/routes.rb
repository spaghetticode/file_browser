Rails.application.routes.draw do
  get 'demo/index'
  root to: 'demo#index'

  mount FsBrowser::Engine => "/fs_browser"
end
