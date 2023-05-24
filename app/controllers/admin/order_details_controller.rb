class Admin::OrderDetailsController < ApplicationController

def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
   if @order_detail.update(order_detail_params)
    if @order.order_detail.where(making_status: "in_production").exists?
       @order.update(status: 2)
    elsif @order.order_detail.where(making_status: "done").count == @order.order_detail.count
       @order.update(status: 3)
    end

        redirect_to admin_order_path(@order_detail.id)
   end
end


  private


  def order_detail_params
     params.require(:order_detail).permit(:making_status)
  end

end

