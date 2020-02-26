class SessionsController < ApplicationController
  # ログインしているか
  skip_before_action :logged_in_user, only: [:new, :create]

  def new                              #　ログイン画面
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash.notice = "ログインしたよ！( *´艸｀)"
      redirect_to root_url
    else
      flash.now[:danger] = 'メールアドレスが間違っているかパスワードが違います'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
