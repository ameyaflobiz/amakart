class OrdersController < ApplicationController
  skip_before_action :authorize_request , only: [:show,:index]

  def index
    # pdf = GeneratePdfWorker.perform_async(3,6,5)
    # File.open(Rails.root.join('report.pdf'),'wb', encoding: 'ascii-8bit') { |f| f.write(pdf)}
    # render json: { message: "Thank you for ordering!,Invoice will be saved on your computer soon"}

  end

  def add_order

    # Basically add orders (REDIS hash/list mai store ho jaayega)
    # render json: "Working"
    order = OrderService.new().add_order_to_redis(order_params)

    # render json: order

  end
  def generate_order

    # Will bundle all orders of that user from REDIS by adding to order_products


    # Delete the orders from REDIS

    # Invoice generation ke liye socho

    @invoice_details = OrderService.new().generate_order(@decoded_id,@decoded_type)
    render json: { message: "Thank you for ordering!,Invoice is being generated",invoice_details: @invoice_details}
  end

  def show

    @invoice_details = OrderProduct.includes(:product,:order).find_by(order_id: params[:id], seller_id: params[:seller_id], product_id: params[:product_id])
    @product = @invoice_details.product
    @order = @invoice_details.order
    @seller_product = SellerProduct.includes(:seller).find_by(seller_id: @seller.id, product_id: @product.id)
    @seller = @seller_product.seller
    @user = @order.user
  end

  private

  def order_params
    params.permit(:product_id,:seller_id).merge(user_id:@decoded_id,user_type: @decoded_type)
  end


end
