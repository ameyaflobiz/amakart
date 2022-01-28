class SellersController < ApplicationController
  skip_before_action :authorize_request, only: [ :create, :login, :get_otp]
  before_action :find_seller, except: [:index, :create, :login, :get_otp]
  # def index
  #   render json: @decoded_type
  # end

  def create
    @seller= Seller.new(seller_params)
    if @seller.save!
        @seller.create_address(billing_address: billing_address_params, shipping_address: shipping_address_params)
        token= JwtService.new().encode({id: @seller.id, type: "seller"})
        render json: {seller: @seller, token: token}, status: :created
    end
  end

  def login
    @seller = Seller.find_by(email: params[:email])

    if @seller && @seller.authenticate(params[:password]) && @seller.authenticate_otp(params[:otp].to_s, drift: 60)

      token = JwtService.new().encode({id: @seller.id, type: "seller"})
      render json:{ token: token, message: "The OTP was valid & a JWT Token has been created and is valid for 24 hours .", seller_email: @seller.email}, status: :ok
    else
      raise CustomException.new("raised in seller login","Invalid credentials/OTP")
    end
  end

  def get_otp
    @seller = Seller.find(params[:id])
    render json: {otp: @seller.otp_code , email: @seller.email}
  end

  private

  def find_seller
    @seller = Seller.find(@decoded_id)
  rescue ActiveRecord::RecordNotFound
    render json:{ errors: 'Seller not found'}, status: :not_found
  end

  def seller_params
    params.permit(:email,:password,:name)
  end

  def billing_address_params
    params.permit(:billing_address => [:line1,:line2,:city,:state,:pincode])
  end

  def shipping_address_params
    params.permit(:shipping_address => [:line1,:line2,:city,:state,:pincode])
  end
end
