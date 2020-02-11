class ArticlesController < ApplicationController
  skip_before_action :logged_in_user, only: [:index, :show, :search]
  before_action :set_article, only: [:show, :edit, :update, :destroy,]

  def index                              # 記事一覧画面
    @article = Article.new
    #　検索フォーム
    @articles = Article.search(params[:search])
    # ページネーション
    @articles = @articles.page(params[:page])
    # ランキング
    @all_ranks = Article.create_all_ranks
    if logged_in?
      # 自分のランキング
      @my_ranks = @all_ranks.select{ |article| article.user_id == current_user.id }
      #　月別アーカイブ
      @user = User.find(current_user.id)
      @archives = @user.make_archive
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
    if logged_in?
      # 自分のランキング
      @my_ranks = @all_ranks.select{ |article| article.user_id == current_user.id }
      #　月別アーカイブ
      @user = User.find(current_user.id)
      @archives = @user.make_archive
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

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
