class Article < ApplicationRecord
  # ユーザーと関連
  belongs_to :user
  # 多くの記事コメントを持つ、諸共削除
  has_many :article_comments, dependent: :destroy
end

