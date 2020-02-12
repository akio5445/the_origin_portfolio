class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # created_atをもとに月別に記事を集計するメソッド
  def make_archive
    return self.articles.group("strftime('%Y%m', articles.created_at)")
               .order(Arel.sql("strftime('%Y%m', articles.created_at) desc"))
               .count
  end
end
