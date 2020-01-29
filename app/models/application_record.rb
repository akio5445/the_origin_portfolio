class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # カスタムクエリー用メソッド(新しい順に取得)
  scope :recent, -> { order(create_at: :desc) }
end
