class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false            # 名前
      t.string :email, null: false           #　メールアドレス
      t.string :password_digest, null: false # パスワード

      t.timestamps
      t.index :email, unique: true           #　唯一のメールアドレス
    end
  end
end