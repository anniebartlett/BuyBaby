Rails.application.routes.draw do
  devise_for :users
  root to: 'products#home'

  resources :products do
    resources :product_orders, only: :create
  end

  resources :orders, only: [ :index, :show, :edit, :update ]



  resources :reviews, only: [:new, :create]

  resources :reviews, only: [:destroy]

  resources :product_orders, only: [:destroy]

end
