Rails.application.routes.draw do
  devise_for :users
  root to: 'products#home'

  resources :products do
    resources :product_orders, only: :create
    resources :reviews, only: [:new, :create, :destroy]
  end

  resources :orders, only: [ :index, :show, :edit, :update ]


  resources :product_orders, only: [:destroy]

  get 'my_account', to: 'orders#my_account'
  get 'basket', to: 'orders#basket'
end
