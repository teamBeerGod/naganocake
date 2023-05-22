class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    # @shipping_address = ShippingAddress.new
    # @shipping_address.customer_id = current_user
    # @shipping_address.post_code =
    # @shipping_address.address =
    # @shipping_address.delivery_name =
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:selection_address] == 0
      # 仮指定（ログイン機能実装後修正する）
      @order.post_code = "current_user.pust_code"
      @order.address = "current_user.address"
      @order.name = "current_user.full_name"
    elsif params[:order][:selection_address] == 1
      @shipping_address = ShippingAddress.find(params[:order][:shipping_address_id])
      @order.post_code = @shipping_address.delivery_name
      @order.address = @shipping_address.address
      @order.name = @shipping_address.delivery_name
    elsif params[:order][:selection_address] == 2
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:delivery_name]
    end

    @order.customer_id = 1
    @order.payment_method = params[:order][:payment_method]
    @order.status = 0

    @order.shipping_cost = 800
    @order.billing_amount = @order.shipping_cost

    @cart_items = CartItem.all
    # @order_detail = OrderDetail.new
    # @order_detail.product_id =
    # @order_detail.price_including_tax =
    # @order_detail.quantity
    # @order_detail.making_status　デフォルトだから削除でOK？

  end

  def thanks
  end

  def create
  end

  def index
  end

  def show
  end

  def order_params
    params.require(:order).permit(
      :customer_id,
      :post_code,
      :address,
      :name,
      :payment_method,
      :status,
      :billing_amount,
      :shipping_cost
    )
  end

  def add_tax
    (self.price_without_tax * 1.10).round
  end

  def calc_subtotal
    (self.price_without_tax * 1.10 * self.quantity).roud
  end
end
