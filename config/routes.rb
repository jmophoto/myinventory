Inspeckd::Application.routes.draw do
  resources :images
  resources :users, only: [:new, :create, :edit, :update]
  resources :properties
  resources :inspections do
    resources :images
    resources :inspected_rooms
    resources :inspection_details
  end
  resources :inspected_rooms do
    resources :images
    resources :inspected_features
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :inspection_details
  
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/profile', to: 'users#edit'

  root 'static_pages#home'
end
