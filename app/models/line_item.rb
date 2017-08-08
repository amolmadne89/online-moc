class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product, :class_name=> "Product", :foreign_key => "item_id"
end
