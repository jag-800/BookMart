class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    @order = Order.find(params[:order_id])
    @order_detail = @order.order_details.find(params[:id])
    
    if @order_detail.update(order_detail_params) && @order_detail.in_production?
      @order.in_production!
    elsif @order.are_all_details_completed?
      @order.preparing_shipment!
    end
    redirect_to admin_order_path(@order)
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
