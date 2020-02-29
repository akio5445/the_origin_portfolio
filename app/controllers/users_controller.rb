class UsersController < ApplicationController
  before_action :set_user, only: [
    :show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [
    :show, :edit, :update, :destroy]
  before_action :correct_user, only: [
    :show, :edit, :update, :destroy]
  def show                               # user詳細画面
    @article = Article.new
  end

  def new                                #　新規登録画面
    @user = User.new
  end

  def edit
  end

  def create                             # 新規登録
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash.notice = "登録完了しました！"
      redirect_to @user
    else
      flash.now.alert = "登録に失敗しました！"
      render 'new'
    end
  end

  def update
     if @user.update_attributes(user_params)
      flash.notice = "登録完了しました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash.notice = "ログインして下さい"
      redirect_to login_url
    end
  end
  # 正しいユーザーかどうか確認
  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end
end