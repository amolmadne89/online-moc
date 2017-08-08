class ReportsController < ApplicationController
	before_action :authenticate_admin
	layout "admin/application"
	def orders
		set_date
    set_users
    @orders = Order.branch_order_report(current_user, @start_date, @end_date)
    @total = @orders.get_total_amount
	end

  def category
    set_date
    @categories = Category.all
    @line_items = Category.order_line_items(current_user, @start_date, @end_date)
  end

	private
    def set_user
      @user = User.find(params["id"])
    end

    def set_date
      @start_date = params[:display_from].present? ? (params[:display_from].to_time.at_beginning_of_day.to_s) : (Time.now - 1.week).at_beginning_of_day.to_s
      @end_date = params[:display_upto].present? ? (params[:display_upto].to_time.at_end_of_day.to_s) : Time.now.at_end_of_day.to_s
    end

    def set_users
      if params['user_ids'].present?
        @users = User.where(id: params['user_ids'])
      else
        @users = User.all
      end
    end
end
