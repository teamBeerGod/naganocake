class Public::ShippingAddressesController < ApplicationController
  def index
    @shipping_address = ShippingAddress.new

    #ログイン実装までの仮↓
    @shipping_addresses = ShippingAddress.all
  end

  def create
    @shipping_address = ShippingAddress.new(address_params)
    @shipping_address.customer_id = 1 #仮
    if @shipping_address.save
      redirect_to :index, notice: "配送先を登録しました"
    else
      render :index
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address = ShippingAddress.new(address_params)
    @shipping_address.customer_id = 1 #仮
    if @shipping_address.save
      redirect_to :index, notice: "配送先を変更しました"
    else
      render :edit
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy
    @shipping_address = ShippingAddress.new
    redirect_to :index
  end

  def address_params
    params.require(:shipping_address).permit(:postcode, :address, :delivery_name)
  end
end
