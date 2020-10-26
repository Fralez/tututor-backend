# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index show create]
  get '/users/show/invitations', to: 'users#show_user_invitations'
  get '/users/filter/without_institution', to: 'users#users_without_institution'
  post '/users/clear_institution', to: 'users#clear_institution'
  post '/users/invitations/accept', to: 'users#accept_invitation'
  post '/users/invitations/reject', to: 'users#reject_invitation'

  resources :questions, only: %i[index show create]
  get '/search/questions', to: 'questions#search_question'
  post '/questions/vote', to: 'questions#vote_question'
  post '/questions/save', to: 'questions#save_question'
  post '/questions/correct_answer', to: 'questions#mark_correct_answer'

  resources :sessions, only: %i[create]
  get '/sessions/logged_in', to: 'sessions#logged_in'
  delete '/sessions/logout', to: 'sessions#logout'

  resources :answers, only: %i[index show create]
  post '/answers/vote', to: 'answers#vote_answer'

  resources :categories, only: %i[create]

  resources :institutions, only: %i[index show create]
  post '/institutions/update_creator', to: 'institutions#update_creator'
  post '/institutions/invitations/create', to: 'institutions#create_invitation'

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :channels, only: %i[index create]
  get '/channels/:user_one_id/:user_two_id', to: 'channels#show'

  get '/messages/:channel_id', to: 'messages#index'
  resources :messages, only: %i[create]
end
