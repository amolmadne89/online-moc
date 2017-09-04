class OrdersController < ApplicationController

  def index

  end

  def new
    @order = Order.new
  end

  def create
    if current_user.blank?
      if User.find_by_email(params["order"]["email"]).blank?
        @user= User.create(:first_name=> params["order"]["first_name"], :last_name=> params["order"]["last_name"], :role_id=> 4, :email=> params["order"]["email"], :mobile_number=> params["order"]["mobile"], :password=> "pass@" + params["order"]["first_name"].downcase)
        sign_in(@user)
      else
        @user = User.find_by_email(params["order"]["email"])
        sign_in(@user)
      end
    end
    @order = Order.new(order_params)
    if @order.save
      @cart = Cart.find(session[:current_cart_id])
      @order.update_shipping_address(@cart, current_user)
      redirect_to place_order_order_path(@order)
    else
      redirect_to request.referer
      flash[:danger] = "Your Delivery Address Is Out Of The Range" 
    end
  end

  def update

  end

  def place_order
    @order = Order.find(params["id"])
    @order.update_column(:total_price, @order.cart.grand_total_amt)
  end

  def thanks_page
    @order = Order.find(params["id"])
    if current_user.is_customer
      @order.update_column(:order_status, "pending")
      current_user.update_column(:branch_id, @order.branch_id) if current_user.branch_id.blank?
      notification = Notification.create(notifiable_type: 'Order', notifiable_id: @order.id, is_checked: false, branch_id: @order.branch_id)
    else  
      @order.update_column(:order_status, "confirmed")
    end
    session[:current_cart_id] = nil
  end

  private

  def order_params
    params.require(:order).permit!
  end
end
