FsBrowser::Engine.routes.draw do
  resources :paths, :only => :create
end
