Rails.application.routes.draw do
  root to: redirect("/users")
  resources :users

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  get "/signout", to: "sessions#destroy"
end
