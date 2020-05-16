# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index show create]
  resources :questions, only: %i[index show create]

  post '/auth/login', to: 'authentication#login'
  post '/auth/renew', to: 'authentication#renew'
end
