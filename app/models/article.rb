class Article < ApplicationRecord
  validates :title, presence: { message: 'タイトルが空欄だよ？' }
  validates :description, presence: { message: '本文が空欄だよ？' }
  # ユーザーと関連
  belongs_to :user
  # 多くの記事コメントを持つ、諸共削除
  has_many :article_comments, dependent: :destroy
  # タイトル検索用メソッド
  has_many :favorites
  #　カテゴリー
  has_many :article_category_relations
  has_many :article_categories, through: :article_category_relations
  # 渡した配列に含まれているIDを持つ他の記事を探してくる
  scope :category_id_in, -> article_category_ids {
    joins(:article_categories).merge(ArticleCategory.id_in article_category_ids)
  }

  def self.create_all_ranks # articleクラスからデータを取ってくる処理なのでクラスメソッド！
    Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
  end

  def self.search(search)
    return Article.all.order(created_at: :desc) unless search
    Article.where(['title LIKE ?', "%#{search}%"],)
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end