Rails.application.routes.draw do
  devise_for :users
  root to: 'products#home'

  resources :products do
    resources :product_orders, only: [ :create, :destroy ]
  end

  resources :orders, only: [ :index, :show, :edit, :update, :destroy ] do
    get 'basket', to: 'orders#basket'
    get 'checkout', to: 'orders#checkout'
    get 'confirmation_page', to: 'orders#confirmation_page'
  end


  resources :product_orders, only: [:destroy]

  get 'my_account', to: 'orders#my_account'
end
