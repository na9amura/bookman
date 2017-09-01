Rails.application.routes.draw do
  root to: 'application#index'

  get 'login', to: 'application#login'

  resources :user_tokens, only: %i(create), controller: :user_token
  resources :books
  resources :checkouts
  resources :checkins
end
