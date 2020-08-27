Rails.application.routes.draw do
  devise_for :users
  root to: 'products#home'

  resources :products do
    resources :orders, only: [ :new, :create, :show ]
    resources :product_orders, only: :create


  end

  resources :orders, except: [ :new, :create ]

  resources :reviews, only: [:new, :create]

  resources :reviews, only: [:destroy]

  resources :product_orders, only: :destroy

end
