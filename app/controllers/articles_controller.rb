class ArticlesController < ApplicationController
  # ログインしているか
  skip_before_action :logged_in_user, only: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy,]

  def index                            # 記事一覧画面
    @article = Article.new
    @articles = Article.all.order(create_at: :desc)
  end

  def show                             # 記事表示画面
    @article_comment = ArticleComment.new
    @article_comments = @article.article_comments
    @articles = Article.all.order(create_at: :desc)
  end

  def edit                             # 記事編集画面
  end

  def new                              # 記事作成画面
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to user_path(current_user), notice: "記事を更新したよ！( *´艸｀)"
    else
      @articles = Article.all
      @user = User.find(current_user.id)
      render action: :index
    end
  end

  def destroy
    @article.destroy
    redirect_to user_path(current_user), notice: "綺麗に消せたよ！( *´艸｀）"
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
