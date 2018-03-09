class CreateProductImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_images do |t|
      t.belongs_to :product
      t.attachment :image
      t.integer :weight, default: 0
      t.timestamps
    end
  end
end
