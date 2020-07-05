# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index show create]

  resources :questions, only: %i[index show create]
  post '/questions/vote', to: 'questions#vote_question'
  post '/questions/save', to: 'questions#save_question'
  get '/search/questions', to: 'questions#search_question'

  resources :sessions, only: %i[create]
  get '/sessions/logged-in', to: 'sessions#logged_in'
  delete '/sessions/logout', to: 'sessions#logout'
end
