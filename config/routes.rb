Rails.application.routes.draw do
# Aboutページ
  root "top#index"

  get    "/login",   to: "sessions#new", as: :login
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :users, only: [ :show, :new, :create ]
  resources :articles do
    resource :article_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

# 月別アーカイブページ " /user/X/archives/20XX0X0X "
  get  "/users/:id/archives/:yyyymm", to: "users#archives", as: :user_archive
end
