class OrdersController < ApplicationController
  skip_before_action :authorize_request , only: [:show,:index]

  def index
    # pdf = GeneratePdfWorker.perform_async(3,6,5)
    # File.open(Rails.root.join('report.pdf'),'wb', encoding: 'ascii-8bit') { |f| f.write(pdf)}
    # render json: { message: "Thank you for ordering!,Invoice will be saved on your computer soon"}

  end
  def generate_order

    @invoice_details = OrderService.new().add_order(order_params)
    render json: { message: "Thank you for ordering!,Invoice is being generated",invoice_details: @invoice_details}
  end

  def show

    @invoice_details = OrderProduct.find_by(order_id: params[:id], seller_id: params[:seller_id])
    @product = Product.find(@invoice_details.product_id)
    @seller = Seller.find(params[:seller_id])
    @order = Order.find(@invoice_details.order_id)
    @seller_product = SellerProduct.find_by(seller_id: @seller.id, product_id: @product.id)
    @user = User.find(@order.user_id)

  end

  private

  def order_params
    params.permit(:product_id,:seller_id).merge(user_id:@decoded_id,user_type: @decoded_type)
  end

end
