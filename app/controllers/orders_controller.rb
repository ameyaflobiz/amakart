class OrdersController < ApplicationController
  skip_before_action :authorize_request , only: [:show,:index]

  def index
    # pdf = GeneratePdfWorker.perform_async(3,6,5)
    # File.open(Rails.root.join('report.pdf'),'wb', encoding: 'ascii-8bit') { |f| f.write(pdf)}
    # render json: { message: "Thank you for ordering!,Invoice will be saved on your computer soon"}
    # orders = Order.includes(:order_products).where(user_id: @decoded_id)
    orders = OrderService.new().fetch_orders(@decoded_id)
    render json: orders.order_products

  end

  def add_order

    # Basically add orders (REDIS hash/list mai store ho jaayega)
    # render json: "Working"
    order = OrderService.new().add_order_to_redis(order_params)

    render json: order

  end
  def generate_order

    # Will bundle all orders of that user from REDIS by adding to order_products


    # Delete the orders from REDIS

    # Invoice generation ke liye socho

    OrderService.new().generate_order(@decoded_id,@decoded_type)
    render json: { message: "Thank you for ordering!,Invoice is being generated"}
  end

  def show

    @invoice_details = OrderProduct.includes(:product,:order).find(params[:invoice_id])
    @product = @invoice_details.product
    @order = @invoice_details.order
    @seller_product = SellerProduct.includes(:seller).find_by(seller_id: @invoice_details.seller_id, product_id: @product.id)
    @seller = @seller_product.seller
    @user = @order.user
  end

  private

  def order_params
    params.permit(:product_id,:seller_id,:quantity).merge(user_id: @decoded_id,user_type: @decoded_type)
  end


end
