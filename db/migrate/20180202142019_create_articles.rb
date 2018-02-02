class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.integer :creator_id,  null: false, limit: 8
      t.text    :content,     null: false
      t.boolean :enabled,     null: false, default: true
      t.integer :read_times,  null: false, limit: 4, default: 0

      t.timestamps
    end

    add_foreign_key :articles, :users, column: :creator_id, primary_key: :id, name: :fk_articles_reference_creator_id
  end
end
