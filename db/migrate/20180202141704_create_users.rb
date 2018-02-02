class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :name,    null: false, limit: 20
      t.boolean :enabled, null: false, default: true
      t.integer :uid,     null: false
      t.integer :level,   null: false

      t.timestamps
    end
  end
end
