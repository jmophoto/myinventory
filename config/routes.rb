Inspeckd::Application.routes.draw do
  resources :images
  resources :plans
  resources :users do
    resources :accounts
    resource :customer do
      resources :credit_cards
      resource :subscription
    end
  end
  resources :credit_cards
  resources :payment_methods
  resources :properties do
    resources :rooms
  end
  resources :inspections do
    resources :images
    resources :inspected_rooms
    resources :inspection_details
    resources :valuables

    get 'email', to: 'inspections#email'
  end
  resources :valuables
  resources :inspected_rooms do
    resources :images
    resources :inspected_features
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :inspection_details
  resources :messages
  resources :accounts do
    resources :images
  end
  resources :addresses
  resources :companies

  namespace :admin do
    resources :users
  end
  
  # agent access
  get '/admin_inspections', to: 'inspections#admin_index'
  get '/agent_inspections', to: 'inspections#agent_index'
  get '/agents', to: 'users#agent_index'
  get '/agents/:status', to: 'users#agent_index'
  get '/coupons', to: 'coupons#index'
  get 'coupons/:code', to: 'coupons#show'
  
  # admin access
  get 'admin', to: 'static_pages#admin'
  
  post '/create_new_subscription', to: 'braintree#create_new_subscription'
  post 'submit_transaction', to: 'braintree#submit_transaction'
  post '/add_card', to: 'braintree#add_card'
  get 'braintree_notification', :to => 'braintree#verify'
  post 'braintree_notification', :to => 'braintree#notify'
    
  
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match 'new_agent', to: 'users#new_agent',     via: 'get'
  
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/profile', to: 'users#edit'
  get '/faq', to: 'static_pages#faq'
  get '/user_faq', to: 'static_pages#user_faq'
  get '/toc', to: 'static_pages#toc'
  get '/list', to: 'static_pages#list'
  get '/services', to: 'static_pages#services'

  root 'static_pages#home'
end
