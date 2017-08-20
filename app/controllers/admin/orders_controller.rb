class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin
  before_action :set_order, only: [:show, :edit, :update, :destroy, :set_notification_nil]
  layout "admin/application"
  require 'order_pdf'
  def index
    @orders = Order.where(branch_id: current_user.branch_id).order("created_at asc NULLS FIRST")
  end
  # def new
  #   @product = Product.new
  #   #@client.addresses.build
  # end

  # def create
  #   @product = Product.new(product_params)
  #   if @product.save
  #     @product.update_column(:category_id, params[:category_id].values.last.to_i)
  #     redirect_to admin_products_path
  #   else
  #     render "new"
  #   end
  # end

  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = GenerateOrderPdf.create_pdf(@order)
        send_data(pdf.render(), :filename => 'order.pdf', :type => :pdf)
      end
    end
  end

  def edit
    respond_to :js
  end

  def update
    @order.update_attributes(order_params)
    redirect_to admin_orders_path
  end

  def set_notification_nil
    notification = Notification.find_by_notifiable_id(@order.id)
    notification.update_attributes(is_checked: true)
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit!
  end

  def set_order
    @order = Order.find(params["id"])
  end
end
