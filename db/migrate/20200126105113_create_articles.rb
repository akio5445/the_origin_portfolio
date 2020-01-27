class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false          # 記事タイトル
      t.text :description, null: false      # 記事内容
      t.integer :user_id, null: false       #　ユーザー関連

      t.timestamps
    end
  end
end