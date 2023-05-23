class Admin::ProductsController < ApplicationController
  
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      #flash[:notice] = "登録が完了しました"
      redirect_to admin_product_path(@product)
    #else
      #flash[:alert] = "登録に失敗しました"
      #render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      #flash[:notice] = "変更が完了しました"
      redirect_to admin_product_path(@product)
    #else
      #flash[:notice] = "登録に失敗しました"
      #render :edit
    end
  end
  
  private
  
  def product_params
    params.require(:product).permit(:name, :introduction, :price_without_tax, :is_active, :genre_id, :image)
  end
  
end
