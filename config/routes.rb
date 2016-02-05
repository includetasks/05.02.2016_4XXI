Rails.application.routes.draw do
  root 'portfolios#index'
  devise_for :users

  resources :portfolios, except: [:new] do
    resources :stocks, only: [:create, :destroy]
  end
end
