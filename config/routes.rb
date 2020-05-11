# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :users
  resources :users, only: [:index, :show, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/auth/login', to: 'authentication#login'
  post '/auth/renew', to: 'authentication#renew'
end
