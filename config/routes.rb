Rails.application.routes.draw do
  root to: "home#index"

  resource :registration, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resource :subscription, only: [:new, :create]

  resources :users, only: [:show]
  resources :posts, except: [:new] do
    resources :posts, only: [:create]
  end

  namespace :admin do
    resources :users
    resources :posts
  end
end
