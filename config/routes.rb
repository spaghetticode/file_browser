FileBrowser::Engine.routes.draw do
  resources :paths, :only => :show
end
