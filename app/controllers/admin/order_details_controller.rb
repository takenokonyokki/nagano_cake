class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    if params[:order_detail][:making_status] == "in_production"
      @order.update(status: "in_production")
    end
    @order_details = @order.order_details
    count = 0
    @order_details.each do |order_detail|
      if order_detail.making_status == "production_complete"
        count += 1
      end
    end
    if @order_details.count == count
      @order.update(status: "preparing_delivery")
    end
    redirect_to admin_order_path(@order_detail.order.id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
