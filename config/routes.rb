Inspeckd::Application.routes.draw do
  resources :properties

  devise_for :users
  get "static_pages/home"
  get "static_pages/about"
  get "static_pages/signup"
  get "static_pages/contact"
  
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_up", :to => "devise/registrations#new"
  end

  root 'static_pages#home'
end
