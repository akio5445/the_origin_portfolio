Rails.application.routes.draw do
# Aboutページ
  root "top#index"
# loginページ
  get    "/login",   to: "sessions#new", as: :login
  resource :sessions, only: [:create, :destroy]
  resources :users, only: [ :show, :new, :create ]
  resources :articles do
    resources :article_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
# 月別アーカイブページ " /user/X/archives/20XX0X0X "
  get  "/users/:id/archives/:yyyymm", to: "users#archives", as: :user_archive
end
