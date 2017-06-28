class Category < ActiveRecord::Base
  has_many :photos, :as => :imageable, dependent: :destroy
  has_many :products
  validates :category_name, :category_code, uniqueness: true
  validates :category_name, :category_code, presence: true
  accepts_nested_attributes_for :photos
end
