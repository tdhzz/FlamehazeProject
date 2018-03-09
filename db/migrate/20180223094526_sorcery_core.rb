class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name,             :null => false
      t.string :crypted_password
      t.string :salt
      t.string :cellphone

      t.timestamps                :null => false
    end

    add_index :users, :email
    add_index :users, :cellphone
  end
end
