class Article < ApplicationRecord
  validates :title, presence: { message: 'タイトルが空欄だよ？' }
  validates :description, presence: { message: '本文が空欄だよ？' }

  # ユーザーと関連
  belongs_to :user
  # 多くの記事コメントを持つ、諸共削除
  has_many :article_comments, dependent: :destroy
  # タイトル検索用メソッド
  has_many :favorites

  def self.create_all_ranks #articleクラスからデータを取ってくる処理なのでクラスメソッド！
    Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
  end
  def self.search(search) #クラスメソッド！
    return Article.all.order(create_at: :desc) unless search
    Article.where(['title LIKE ?', "%#{search}%"],)
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end