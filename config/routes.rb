Inspeckd::Application.routes.draw do
  get "users/new"
  get "static_pages/home"
  get "static_pages/about"
  get "static_pages/signup"
  get "static_pages/contact"

  root 'static_pages#home'
end
