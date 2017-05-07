Rails.application.routes.draw do
  root to: "posts#index"

  get "/about", to: "pages#about"
  get "/policies", to: "pages#policies"

  resource :confirmation, only: [:new, :create, :show]
  resource :messages, only: [:new, :create]
  resource :registration, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resource :subscription, only: [:new, :create]

  resources :users, only: [:show, :edit, :update]
  resources :posts, except: [:new] do
    resources :posts, only: [:create]
  end

  namespace :admin do
    root to: "dashboard#index"
    resources :users
    resources :posts
  end
end
