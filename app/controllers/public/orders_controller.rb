class Public::OrdersController < ApplicationController

  before_action :cart_item_state, only: [:new]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        order_details = OrderDetail.new
        order_details.item_id = cart_item.item_id
        order_details.order_id = @order.id
        order_details.price = cart_item.item.price
        order_details.amount = cart_item.amount
        order_details.save
      end
    @cart_items.destroy_all
    redirect_to complete_public_orders_path
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_option] == "1"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    elsif params[:order][:address_option] == "2"
      @order = current_customer.orders.new(order_params)
    end
    @order.shipping_cost = 800
  end

  def index
    @orders = current_customer.orders
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

  protected
  def cart_item_state
    @cart_items = current_customer.cart_items
      if @cart_items.any?
      else
        redirect_to public_items_path
      end
  end

end
