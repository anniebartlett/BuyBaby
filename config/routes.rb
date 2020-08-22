Rails.application.routes.draw do
  devise_for :users
  root to: 'products#home'

  resources :products do
    resources :orders, only: [ :new, :create ]
  end

  resources :orders, except: [ :new, :create ]

  resources :reviews, only: [:new, :create]

  resources :reviews, only: [:destroy]
end
