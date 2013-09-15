Inspeckd::Application.routes.draw do
  resources :users, only: [:new, :create, :edit, :update]
  resources :properties
  resources :inspections do
    resources :inspected_rooms
  end
  resources :inspected_rooms do
    resources :inspected_features
  end
  resources :sessions, only: [:new, :create, :destroy]
  
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/profile', to: 'users#edit'

  root 'static_pages#home'
end
