class User < ApplicationRecord
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
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
