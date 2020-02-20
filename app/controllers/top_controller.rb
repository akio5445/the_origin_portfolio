class TopController < ApplicationController
  skip_before_action :logged_in_user

  def index
    #　検索フォーム
    @articles = Article.search(params[:search])
    # ページネーション
    @articles = @articles.page(params[:page])
    # ランキング
    @all_ranks = Article.create_all_ranks
    # カテゴリー
    @categories = ArticleCategory.all
    if logged_in?
      # 自分のランキング
      @my_ranks = @all_ranks.select{ |article| article.user_id == current_user.id }
    end
  end
end
