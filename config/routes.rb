Rails.application.routes.draw do
  root to: 'application#index'

  get 'login', to: 'application#login'

  resources :user_tokens, only: %i(create), controller: :user_token
  resources :books do
    resources :tags
  end
  resources :tags, only: %i(index)
  resources :checkouts
  resources :checkins
  resources :shelves, only: %i(index)
  resources :amazon_books_api, only: %i(index)

  get '*path', to: 'application#index', constraints: -> (request) do
    !request.xhr? && request.format.html?
  end
end
