class CreateArticleCategoryRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :article_category_relations do |t|
      t.integer "article_id"
      t.integer "article_category_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
