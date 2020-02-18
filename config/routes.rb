Rails.application.routes.draw do
# Aboutページ
  root "top#index"

  get    "/login",   to: "sessions#new", as: :login
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
　get '/article_categories/:id/show', to: "articles#category",  as: :category
  resources :users, only: [ :show, :new, :create ]
  resources :articles do
    resources :article_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end
