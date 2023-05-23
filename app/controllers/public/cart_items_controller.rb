class Public::CartItemsController < ApplicationController
  def index
#    @cart_items = curremt_customer.cart_items
    @cart_items = CartItem.all

  end

  def create
    if true
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = 1 #current_customer.id
      @cart_item.save
    else

    end
  end

  def update

  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to :index
  end

  def destroy_all
    @cart_items = current_customer.cart_item
    @cart_items.destroy_all
    redirect_to :index
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
