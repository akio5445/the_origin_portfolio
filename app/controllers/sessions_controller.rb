class SessionsController < ApplicationController
  # ログインしているか

  def new                              #　ログイン画面
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      flash.notice = "ログインしたよ！( *´艸｀)"
      redirect_back_or @user
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
