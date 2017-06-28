class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
    t.integer :cart_id
    t.integer :quantity
    t.float :item_price
    t.float :item_price_with_quantity
    t.text :item_description
    t.integer :item_id
    t.string :mobile_no
    t.string :user_email
    t.string :order_status
    t.timestamps null: false
    end
  end
end
