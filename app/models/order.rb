class Order < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode
  belongs_to  :user
  belongs_to  :cart
  belongs_to  :branch
  validate :set_branch
  def update_shipping_address(cart, user)
    self.update_columns(:shipping_first_name=> self.first_name, :shipping_last_name=> self.last_name, :shipping_email=> self.email, :shipping_mobile=> self.mobile, :shipping_city=> self.city, :shipping_state=> self.state, :shipping_address=> self.address, :shipping_pincode=> self.pincode, :cart_id=> cart.id, :user_id=> user.id)
    cart.update_column(:user_id, user.id)
  end

  def order_data
    products = []
    self.cart.line_items.each do |item|
      products << [Product.find(item.item_id).product_name, item.item_price, item.quantity, item.item_price_with_quantity]
    end
    if products.count == 5
      return [["<b>Product Name</b>", "<b>Product Price</b>", "<b>Quantity</b>", "<b>Total Price</b>"], products.first, products.second, products.third, products.fourth, products.last]
    elsif products.count == 4
      return [["<b>Product Name</b>", "<b>Product Price</b>", "<b>Quantity</b>", "<b>Total Price</b>"], products.first, products.second, products.third, products.last]
    elsif products.count == 3
      return [["<b>Product Name</b>", "<b>Product Price</b>", "<b>Quantity</b>", "<b>Total Price</b>"], products.first, products.second, products.last]
    elsif products.count == 2
      return [["<b>Product Name</b>", "<b>Product Price</b>", "<b>Quantity</b>", "<b>Total Price</b>"], products.first, products.last]
    else
      return [["<b>Product Name</b>", "<b>Product Price</b>", "<b>Quantity</b>", "<b>Total Price</b>"], products.first]
    end
  end

  def self.branch_order_report(user, start_date, end_date)
    orders = Order.where("branch_id =? and created_at >=(?) and created_at <=(?)", user.branch_id, start_date, end_date)
  end

  def self.get_total_amount
    total = all.sum('total_price')
  end

  def set_branch
    if self.branch_id.blank?
      distance_array = []
      Branch.all.each do |branch|
        distance = Geocoder::Calculations.distance_between([self.latitude,self.longitude], [branch.latitude,branch.longitude])
        distance_array << {branch: branch.id, distance: distance}
      end
      min_hash = distance_array.min_by{|x| x[:distance]}
      if min_hash[:distance] < 6
        branch_id = min_hash[:branch]
        self.branch_id = branch_id
      else
        self.errors.add(:base, "Sorry your adress is not in our range")
        return false
      end
    end
  end
end
