class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # カスタムクエリー用メソッド(新しい順に取得)
  scope :recent, -> { order(create_at: :desc) }

  # creatd_atをもとに月別に記事を集計するメソッド
  def make_archive
    return self.articles.group("strftime('%Y%m', articles.created_at)")
               .order(Arel.sql("strftime('%Y%m', articles.created_at) desc"))
               .count
  end
end
