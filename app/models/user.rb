class User < ApplicationRecord
  # 多くの記事と関連、諸共削除
  has_many :articles, dependent: :destroy
  # 多くの記事コメントと関連、諸共削除
  has_many :article_comments, dependent: :destroy

  # セキュアにハッシュ化したパスワードを、 データベース内のpassword_digestという属性に保存できるようになる。
  # 2つのペアの仮想的な属性（passwordとpassword_confirmation）が使えるようになる。
  # また、存在性と値が一致するかどうかのバリデーションも追加される 。
  # authenticateメソッド追加（引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド）。
  has_secure_password
end
