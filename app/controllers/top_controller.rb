class TopController < ApplicationController
  # ログインしているか
  skip_before_action :logged_in_user

  def index
    @articles = Article.all.order(create_at: :desc)
  end
end
