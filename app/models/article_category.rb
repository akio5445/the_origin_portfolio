class ArticleCategory < ApplicationRecord
  has_many :article_category_relations
  # 中間テーブルのpost_category_relationsを経由して、関連付け
  has_many :articles, through: :article_category_relations

  scope :id_in, -> ids {
    where(id: ids) if ids.present?
  }
end
