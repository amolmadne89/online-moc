class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_code
      t.integer :category_id
      t.text :product_description
      t.float :price
      t.boolean :status
      t.timestamps null: false
    end
  end
end
