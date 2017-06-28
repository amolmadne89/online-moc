class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin
  layout "admin/application"
  require 'order_pdf'
  def index
    @orders = Order.where(branch_id: current_user.branch_id)
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
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(product_params)
    redirect_to admin_products_path
  end

  private

  def order_params
    params.require(:order).permit!
  end
end
