class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin
  layout "admin/application"

  def index
    @products = Product.unscoped.all
  end
  def new
    @product = Product.new
    #@client.addresses.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
    else
      render "new"
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.unscoped.find(params[:id])
  end

  def update
    @product = Product.unscoped.find(params[:id])
    @product.update_attributes(product_params)
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit!
  end
end
