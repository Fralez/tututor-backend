# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index show create]
  resources :questions, only: %i[index show create]
  post '/questions/vote', to: 'questions#vote_question'
  get '/search/questions', to: 'questions#search_question'

  post '/auth/login', to: 'authentication#login'
  post '/auth/renew', to: 'authentication#renew'

  resources :categories, only: %i[create]
end
