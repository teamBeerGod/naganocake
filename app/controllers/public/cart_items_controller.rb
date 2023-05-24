class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = current_customer.cart_items
  end

  def create
    if (params[:cart_item][:quantity]).nil?
      redirect_to request.referer
    end
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(product_id: @cart_item.product_id)
      before_cart_item = CartItem.find_by(product_id: @cart_item.product_id)
      @cart_item.quantity += before_cart_item.quantity
      if @cart_item.save
        before_cart_item.destroy
      end
      redirect_to cart_items_path
    elsif @cart_item.save
      @cart_items = current_customer.cart_items
      redirect_to cart_items_path
    else
      redirect_to request.referer
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to request.referer
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to request.referer
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to request.referer
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity, :customer_id)
  end
end
