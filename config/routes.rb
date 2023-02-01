Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  post 'login', to: 'sessions#create'

  resources :user, only: %i[index create update delete]
end
