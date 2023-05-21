class Public::ProductsController < ApplicationController
  def index
    @products = Product.all
    #商品が登録できるようになったら下記を有効にする?
    #@product = Product.find(params[:id])
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = Cart_item.new
  end
  
    # 商品データのストロングパラメータ
  private

  def product_params
    params.require(:product).permit(:name, :price_without_tax)
  end
  
end
