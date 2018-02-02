class CreateArticleComments < ActiveRecord::Migration[5.1]
  def change
    create_table :article_comments do |t|
      t.integer :article_id,        null: false,  limit: 8
      t.integer :creator_id,        null: false,  limit: 8
      t.string  :content,           null: false,  limit: 200
      t.integer :parent_comment_id, null: true,   limit: 8
      t.boolean :enabled,           null: false,  default: true

      t.timestamps
    end

    add_foreign_key :article_comments, :articles, column: :article_id, primary_key: :id,
                    name: :fk_article_comments_reference_article_id
    add_foreign_key :article_comments, :article_comments, column: :parent_comment_id, primary_key: :id,
                    name: :fk_article_comments_reference_parent_comment_id
    add_foreign_key :article_comments, :users, column: :creator_id, primary_key: :id,
                    name: :fk_article_comments_reference_creator_id
  end

end
