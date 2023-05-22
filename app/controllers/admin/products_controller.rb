class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end
  
  private
  
  def product_params
    params.require(:product).permit(:name, :price_without_tax, :image)
  end
  
end
