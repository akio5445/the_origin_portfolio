Rails.application.routes.draw do
# Aboutページ
  root "top#index"
  get    "/login",   to: "sessions#new", as: :login
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users, only: [ :show, :new, :create ]
  resources :articles do
    resources :article_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  # カテゴリータグ移行先のそのタグが含まれる記事が表示されるページ
  get '/article_categories/:id/show', to: "articles#category",  as: :category
  # サイドバーカテゴリータグ移行先のそのタグが含まれる記事が表示されるページ
  get '/article_category/:id/:name', to: "articles#each_category",  as: :each_category
end
