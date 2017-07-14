class Branch < ActiveRecord::Base
	geocoded_by :unwanted_column
	has_many :orders
	has_many :users
end
