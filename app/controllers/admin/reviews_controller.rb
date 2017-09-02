class Admin::ReviewsController < ApplicationController
	before_action :authenticate_admin
  layout "admin/application"
	def index
		@reviews = Feedback.all
	end
end
