Rails.application.routes.draw do
# Aboutページ
  root "top#index"
# loginページ
  get    '/login',   to: 'sessions#new', as: :login
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
# 月別アーカイブページ ' /user/X/archives/20XX0X0X '
  get  '/users/:id/archives/:yyyymm', to: 'users#archives', as: :user_archive

  resources :users
  resources :articles do
    resources :article_comments
    resource :favorites, only: [:create, :destroy]
  end
end
