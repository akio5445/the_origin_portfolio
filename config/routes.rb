Rails.application.routes.draw do
# Aboutページ
  root "top#index"
# loginページ
  get    '/login',   to: 'sessions#new', as: :login
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :articles do
    resources :article_comments
    resource :favorites, only: [:create, :destroy]
  end
end
