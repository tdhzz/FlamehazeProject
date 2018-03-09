class AddUserNumberColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :number, :string

    add_index :users, [:number], unique: true

    User.find_each do |user|
      user.number = RandomCode.generate_utoken
      user.save
    end
  end
end
