class Product < ActiveRecord::Base
  belongs_to :category
  has_many :line_items
  has_many :photos, :as => :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos
  default_scope { where(status: true) }
end
