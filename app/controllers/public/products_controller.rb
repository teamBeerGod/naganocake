class Public::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @products = Product.find(params[:id])
  end
  
    # 商品データのストロングパラメータ
  private

  def product_params
    params.require(:product).permit(:name, :price_without_tax)
  end
  
end
