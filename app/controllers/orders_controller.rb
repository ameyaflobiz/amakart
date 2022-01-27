class OrdersController < ApplicationController

  def generate_order
    @invoice_details = OrderService.new().add_order(order_params)

    render json: @invoice_details
  end

  private

  def order_params
    params.permit(:product_id,:seller_id).merge(user_id:@decoded_id,user_type: @decoded_type)
  end
end
