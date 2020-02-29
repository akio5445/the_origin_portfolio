class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :category]
  before_action :logged_in_user, only: [:new ,:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:new ,:create, :edit, :update, :destroy]

  def index                              # 記事一覧画面
    @article = Article.new
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

  def show                               # 記事表示画面
    # コメント
    @article_comment = ArticleComment.new
    @article_comments = @article.article_comments
    #　検索フォーム
    @articles = Article.search(params[:search])
    # ランキング
    @all_ranks = Article.create_all_ranks
    # カテゴリー
    @categories = ArticleCategory.all
    if logged_in?
      # 自分のランキング
      @my_ranks = @all_ranks.select{ |article| article.user_id == current_user.id }
    end
  end

  def category
    @ids = @article.article_categories.ids
    # 上記配列に含まれているIDを持つ他の記事を探してくる
    @article_category_id_in = Article.category_id_in(@ids)
    @articles = Article.search(params[:search])
    # ページネーション
    @articles = @articles.page(params[:page])
    # ランキング
    @all_ranks = Article.create_all_ranks
    if logged_in?
      # 自分のランキング
      @my_ranks = @all_ranks.select{ |article| article.user_id == current_user.id }
    end
  end

  def each_category
    @name = ArticleCategory.find(params[:id])
    # 上記のIDを持つ他の記事を探してくる
    @article_category_id_in = Article.category_id_in(@name)
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

  def edit                               # 記事編集画面
  end

  def new                                # 記事作成画面
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash.notice = "記事「#{@article.title}」作成したよ！( *´艸｀)"
      redirect_to @article
    else
      flash.now.alert = "登録に失敗しました！"
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash.notice = "記事を更新したよ！( *´艸｀)"
      redirect_to @article
    else
      @articles = Article.all
      @user = User.find(current_user.id)
      flash.now.alert = "登録に失敗しました！"
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash.notice = "綺麗に消せたよ！( *´艸｀）"
    redirect_to user_path(current_user)
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end
  # チェックボックスによって複数渡される場合があるため、配列ids: []
  def article_params
    params.require(:article).permit(:title,
      :description, article_category_ids: [])
  end

  def article_category_params
    params.require(:article_category).permit(:name)
  end

  def logged_in_user
    unless logged_in?
      flash.notice = "ログインして下さい"
      redirect_to login_url
    end
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
