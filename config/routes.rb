# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  post 'login', to: 'sessions#create'
  post 'deposit', to: 'users#deposit'
  post 'reset', to: 'users#reset'
  post 'buy', to: 'purchases#buy'

  resources :users, only: %i[index create update delete]
  resources :products, only: %i[index create update delete]
end
