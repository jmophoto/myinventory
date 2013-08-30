Inspeckd::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  
  get "users/new"
  get "static_pages/home"
  get "static_pages/about"
  get "static_pages/signup"
  get "static_pages/contact"
  
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  root 'static_pages#home'
end
