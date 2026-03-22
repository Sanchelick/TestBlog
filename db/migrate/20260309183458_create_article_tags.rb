class CreateArticleTags < ActiveRecord::Migration[8.0]
  def change
    create_table :article_tags do |t|
      t.belongs_to :article, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :article_tags, [:article_id, :tag_id], unique: true
  end
end
