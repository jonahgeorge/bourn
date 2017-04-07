Rails.application.routes.draw do
  root to: redirect("/posts")
  resources :users, only: [:new, :create, :show]
  resources :posts

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  get "/signout", to: "sessions#destroy"
end
