# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index show create]

  resources :questions, only: %i[index show create]
  post '/questions/vote', to: 'questions#vote_question'
  post '/questions/save', to: 'questions#save_question'
  get '/search/questions', to: 'questions#search_question'
  post '/questions/correct_answer', to: 'questions#mark_correct_answer'

  resources :sessions, only: %i[create]
  get '/sessions/logged_in', to: 'sessions#logged_in'
  delete '/sessions/logout', to: 'sessions#logout'

  resources :answers, only: %i[index show create]
  post '/answers/vote', to: 'answers#vote_answer'

  resources :categories, only: %i[create]

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
