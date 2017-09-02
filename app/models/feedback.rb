class Feedback < ActiveRecord::Base
	validates :full_name, :email, :mobile, :comment, presence: true
end
