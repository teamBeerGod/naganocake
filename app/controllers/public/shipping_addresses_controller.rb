class Public::ShippingAddressesController < ApplicationController
  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = current_customer.shipping_addresses
  end

  def create
    @shipping_address = ShippingAddress.new(address_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
      redirect_to request.referer, notice: "配送先を登録しました"
    else
      render request.referer
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update(address_params)
      redirect_to shipping_addresses_path
    else
      render request.referer
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy
    @shipping_address = ShippingAddress.new
    redirect_to request.referer
  end

  def address_params
    params.require(:shipping_address).permit(:post_code, :address, :delivery_name)
  end
end
