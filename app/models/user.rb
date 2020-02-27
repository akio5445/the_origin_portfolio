class User < ApplicationRecord
  attr_accessor :remember_token
  validates :name, presence: { message: 'が空欄だよ？' }
  validates :email, presence: { message: 'が空欄だよ？' }
  validates :password, presence: { message: 'きゃんとびいぶらんく☆' }
  has_secure_password
  # 多くの記事と関連、諸共削除
  has_many :articles, dependent: :destroy
  # 多くの記事コメントと関連、諸共削除
  has_many :article_comments, dependent: :destroy
  has_many :favorites

  # 与えられた文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークン
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続的セッションで使用するユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

   # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    if remember_digest.nil?
      false
    else
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
  end

  # ユーザーログインを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
