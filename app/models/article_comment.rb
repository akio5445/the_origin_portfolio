class ArticleComment < ApplicationRecord
  # userと関連
  belongs_to :user
  # articleと関連
  belongs_to :article
  # 空でないこと
  validates :content, presence: true
end
