class Public::OrdersController < ApplicationController
  def new
    cart_items = current_customer.cart_items
    if cart_items.present?
      @order = Order.new
      @shipping_addresses = current_customer.shipping_addresses
    else
      flash[:notice] = "カートが空です"
      redirect_to request.referer
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:selection_address] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:order][:selection_address] == "1"
      @shipping_address = ShippingAddress.find(params[:order][:shipping_address_id])
      @order.post_code = @shipping_address.post_code
      @order.address = @shipping_address.address
      @order.name = @shipping_address.delivery_name
    elsif params[:order][:selection_address] == "2"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:delivery_name]
    end
    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800

  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @cart_items = current_customer.cart_items.each do |item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.product_id = item.product_id
        @order_detail.price_including_tax = item.add_tax
        @order_detail.quantity = item.quantity
        @order_detail.save
      end
      current_customer.cart_items.destroy_all
      redirect_to thanks_path
    else
      @cart_items = current_customer.cart_items
      render confirm_path
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def order_params
    params.require(:order).permit(
      :customer_id,
      :post_code,
      :address,
      :name,
      :payment_method,
      :billing_amount,
      :shipping_cost
    )
  end

end