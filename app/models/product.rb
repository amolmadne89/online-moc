class Product < ActiveRecord::Base
  belongs_to :category
  has_many :line_items
  has_many :photos, :as => :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true
  default_scope { where(status: true) }
end
