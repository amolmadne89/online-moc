class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer  :user_id
      t.integer  :cart_id
      t.float    :total_price
      t.string   :first_name
      t.string   :last_name
      t.string   :email
      t.string   :mobile
      t.string   :landline_no
      t.text     :address
      t.string   :city
      t.string   :state
      t.string   :pincode
      t.string   :shipping_first_name
      t.string   :shipping_last_name
      t.string   :shipping_email
      t.string   :shipping_mobile
      t.string   :shipping_landline_no
      t.text     :shipping_address
      t.string   :shipping_city
      t.string   :shipping_state
      t.string   :shipping_pincode
      t.string   :shipping_landmark
      t.string   :landmark
      t.string   :payment_type
      t.string   :order_status
      t.datetime :exp_delivery_date
      t.boolean  :is_offer
      t.string   :coupon_code
      t.timestamps null: false
    end
  end
end
