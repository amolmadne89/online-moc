class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.float :subtotal_amt
      t.float :grand_total_amt
      t.float :shipping_amt
      t.boolean :is_offer
      t.boolean :status
      t.timestamps null: false
    end
  end
end
