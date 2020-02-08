class UsersController < ApplicationController
  # ログインしているか
  skip_before_action :logged_in_user, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def archives
    @user = User.find(params[:id])
    @yyyymm = params[:yyyymm]
    @articles = @user.articles.where("strftime('%Y%m', articles.created_at) = '"+@yyyymm+"'")
                    .paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    @archives = @user.make_archive

    @articles = Article.search(params[:search])
    # ページネーション
    @articles = @articles.page(params[:page])
    # ランキング
    @all_ranks = Article.create_all_ranks
    # OPTIMIZE 自分のランキング
    @my_ranks = @all_ranks.select{ |article| article.user_id == current_user.id }
  end

  def show                               # user詳細画面
    @article = Article.new
    #　月別アーカイブ
    @archives = @user.make_archive
  end

  def new                                #　新規登録画面
    @user = User.new
  end

  def create                             # 新規登録
    @user = User.new(user_params)
    if @user.save
      flash.notice = "登録完了しました！"
      redirect_to login_path
    else
      flash.now.alert = "登録に失敗しました！"
      render 'new'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
