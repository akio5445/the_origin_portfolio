class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

# created_atをもとに月別に記事を集計するメソッド
#def make_archive #試行錯誤中
#  return self.articles.group("strftime('%Y%m', articles.created_at)")
#             .order(Arel.sql("strftime('%Y%m', articles.created_at) desc"))
#             .count
#end
