Inspeckd::Application.routes.draw do
  resources :images
  resources :users do
    resources :accounts
    resource :customer do
      resources :credit_cards
      resource :subscription
    end
  end
  resources :credit_cards
  resources :payment_methods
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
  resources :messages
  # resources :accounts do
  #   resources :images
  # end
    
  
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/profile', to: 'users#edit'
  get '/account', to: 'subscriptions#show'

  root 'static_pages#home'
end
