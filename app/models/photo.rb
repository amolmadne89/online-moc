class Photo < ActiveRecord::Base
  belongs_to :category
  belongs_to :imageable, polymorphic: true
  has_attached_file :image, :styles => { :small => "180x180#", :thumb => "70x70#" }, path: ":rails_root/public/system/:attachment/:id/:style/:filename",url: "/system/:attachment/:id/:style/:filename"
  validates_attachment  :image, :presence => true, :content_type => { :content_type => %w(image/jpeg image/jpg image/png) }, :size => { :in => 0..1.megabytes }
end
