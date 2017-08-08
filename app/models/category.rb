class Category < ActiveRecord::Base
  has_many :photos, :as => :imageable, dependent: :destroy
  has_many :products
  validates :category_name, :category_code, uniqueness: true
  validates :category_name, :category_code, presence: true
  accepts_nested_attributes_for :photos

  def get_total_price(line_items)
  	total = 0
		line_items.each do |item|
			if item.product.category.category_name == self.category_name
				total = total + item.item_price_with_quantity
			end
		end
		return total
  end

  def self.order_line_items(user, start_date, end_date)
  	items = []
  	Order.branch_order_report(user,start_date, end_date).each do |order|
			order.cart.line_items.each do |item|
				items << item
			end
		end
		return items
  end
end
