module SessionsHelper
  # ブラウザcookieにハッシュ化したuser_idを保存
  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーを永続的セッションに記憶する
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 保存されたユーザーIDを元に、ユーザーの情報を取得
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  #受け取ったユーザーがログイン中のユーザーと一致すればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # cookieの保存されているIDを削除する
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # ログイン済みユーザーかどうか確認
  private def logged_in_user
    unless logged_in?
      redirect_to :login
    end
  end
end