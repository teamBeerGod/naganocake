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
    if params[:order][:selection_address] == "0"
      # 仮指定（ログイン機能実装後修正する）
      @order.post_code = "current_user.pust_code"
      @order.address = "current_user.address"
      @order.name = "current_user.full_name"
    elsif params[:order][:selection_address] == "1"
      @shipping_address = ShippingAddress.find(params[:order][:shipping_address_id])
      @order.post_code = @shipping_address.delivery_name
      @order.address = @shipping_address.address
      @order.name = @shipping_address.delivery_name
    elsif params[:order][:selection_address] == "2"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:delivery_name]
    end

    @order.customer_id = 1
    @order.payment_method = params[:order][:payment_method]
    @order.shipping_cost = 800

    @cart_items = CartItem.all # ログイン機能実装までの仮コード（current_customer.cart_items）
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      # ログイン機能を実装後修正(current_customer.cart_itemsのループ処理)
      @cart_item = CartItem.find_by(customer_id: 1) #最初の一つだけ検索ヒット
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.product_id = @cart_item.product.name
      @order_detail.price_including_tax = @cart_item.add_tax
      @order_detail.quantity = @cart_item.quantity
      @order_detail.save

      # current_customer.cart_items.destroy_all
      redirect_to thanks_path
    else
      @cart_items = CartItem.all # ログイン機能実装までの仮コード　（current_customer.cart_items）
      render confirm_path
    end
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

end