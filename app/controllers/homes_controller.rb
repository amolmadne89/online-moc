class HomesController < ApplicationController

  def index
    @categories = Category.all
  end

  def prodct_by_category
    @prodcuts = Product.where("category_id =?", params[:id])
  end

  def cart
    if params["product"].present?
      @product = Product.find(params["product"])
      if session[:current_cart_id].blank?
        @cart = Cart.create(:subtotal_amt => @product.price, :grand_total_amt => @product.price, :shipping_amt => 0.0, )
        @cart.save
        session[:current_cart_id] = @cart.id
        @line_item = LineItem.create(:cart_id => @cart.id, :item_id => @product.id, :quantity => 1, :item_price => @product.price, :item_price_with_quantity => @product.price)
        if params["add_to_cart"].present?
          redirect_to request.referer
        end
      else
        @cart = Cart.find(session[:current_cart_id])
        if @cart.line_items.pluck(:item_id).include?(@product.id)
          flash[:danger] = "Product Already In The Cart"
        else
          @line_item = LineItem.create(:cart_id => session[:current_cart_id], :item_id => @product.id, :quantity => 1, :item_price => @product.price, :item_price_with_quantity => @product.price)
        end
        if params["add_to_cart"].present?
          redirect_to request.referer
        end
      end
      @cart.update_columns(:subtotal_amt => @cart.line_items.sum(:item_price_with_quantity), :grand_total_amt => @cart.line_items.sum(:item_price_with_quantity))
    end
  end

  def update_query
    if params[:remove_item_id].present?
      @item = LineItem.find(params[:remove_item_id]).destroy
      redirect_to cart_path
    else
      @item = LineItem.find(params["item_id"])
      @item.update_columns(:quantity => params["qty"], :item_price_with_quantity => @item.item_price * params["qty"].to_i )
      @cart = @item.cart
      @cart.update_columns(:subtotal_amt => @cart.line_items.sum(:item_price_with_quantity), :grand_total_amt => @cart.line_items.sum(:item_price_with_quantity))
      data = [:total=>@cart.subtotal_amt,:qty=>@item.quantity,:item_price=>@item.item_price_with_quantity]
      respond_to do |format|
        format.json { render json: data.to_json }
        #format.json { render json: @item.to_json }
      end
    end
  end

  def product_detail
    @product = Product.find(params["id"])
  end
end
