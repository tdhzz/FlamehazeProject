class OrdersController < ApplicationController

  before_action :auth_user

  def new
    fetch_home_data
    @shopping_carts = ShoppingCart.by_user_number(current_user.number)
      .order("id desc").includes([:product => [:main_product_image]])
  end

  def create
    shopping_carts = ShoppingCart.by_user_number(current_user.number).includes(:product)
    if shopping_carts.blank?
      redirect_to shopping_carts_path
      return
    end

    address = current_user.addresses.find(params[:address_id])
    orders = Order.create_order_from_shopping_carts!(current_user, address, shopping_carts)

    redirect_to generate_pay_payments_path(order_nos: orders.map(&:order_no).join(','))
  end

  def do_send_finish
    if @order.status == OrderStatus::Paid
      @payment.do_success_send! params
      redirect_to success_payments_path
    elsif @order.status == OrderStatus::Send
      @payment.do_success_finish! params
      redirect_to success_payments_path
    else
     redirect_to success_payments_path
    end
  end

end
