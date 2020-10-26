# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index show create]
  get '/users/filter/without_institution', to: 'users#users_without_institution'
  post '/users/clear_institution', to: 'users#clear_institution'
  get '/users/invitations', to: 'users#show_user_invitations'

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

  resources :institutions, only: %i[index show create]
  post '/institutions/update_creator', to: 'institutions#update_creator'

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :channels, only: %i[index create]
  get '/channels/:user_one_id/:user_two_id', to: 'channels#show'

  get '/messages/:channel_id', to: 'messages#index'
  resources :messages, only: %i[create]
end
