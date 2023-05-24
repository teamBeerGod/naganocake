class Public::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end

    # 商品データのストロングパラメータ
  private

  def product_params
    params.require(:product).permit(:name, :price_without_tax, :image)
  end

end
