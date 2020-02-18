class ArticleCategoryRelation < ApplicationRecord
  belongs_to :article
  belongs_to :article_category
end
