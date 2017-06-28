class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin
  layout "admin/application"

  def index
    @categories = Category.all
  end
  def new
    @category = Category.new
    #@client.addresses.build
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render "new"
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(category_params)
    redirect_to admin_categories_path
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:danger] = "Category is deleted successfully"
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit!
  end
end
