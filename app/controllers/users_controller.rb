class UsersController < ApplicationController
  skip_before_action :logged_in_user, only: [:new, :create]
  before_action :set_user, only: [
      :show, :edit, :update, :destroy]    # User.find(params[:id])

  def show                               # user詳細画面
  end

  def new                                #　新規登録画面
    @user = User.new
  end

  def edit                               # user編集画面
  end

  def create                             # 新規登録
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render 'new'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
        :name, :email, :password, :password_confirmation)
  end
end
