Rails.application.routes.draw do
  devise_for :users
  root to: 'products#home'

  resources :products do
    resources :orders, only: [ :new, :create, :show ]
    resources :product_orders, only: :create

  end

  resources :orders, except: [ :new, :create ]
  resources :product_orders, only: :destroy
  resources :reviews, only: [:new, :create, :destroy]

  get 'my_account', to: 'orders#my_account'
end
