class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:index, :create, :login, :get_otp]
  before_action :find_user, except: [:index, :create, :login, :get_otp]

  def index
    # raise CustomException.new("custom error code", "Exception raised in index action")
  end

  def create
    @user= User.new(user_params)
    if @user.save!
        token= JwtService.new().encode({id: @user.id, type: "user"})
        render json: {user:@user, token: token}, status: :created
    end
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password]) && @user.authenticate_otp(params[:otp].to_s, drift: 60)

      token = JwtService.new().encode(id: @user.id, type: "user")
      render json:{ token: token, message: "The OTP was valid & a JWT Token has been created and is valid for 24 hours .", username: @user.email}, status: :ok
    
    else 
      raise CustomException.new("raised in user login","Invalid credentials/OTP") 
    end

  end

  def get_otp
    @user = User.find(params[:id])
    render json: {otp: @user.otp_code , email: @user.email}
  end

  private 

  def find_user
    @user = User.find(@decoded_id)
  rescue ActiveRecord::RecordNotFound
    render json:{ errors: 'User not found'}, status: :not_found
  end

  def user_params
    params.permit(:email, :password, :phone_num, :name, :user_type)
  end
end
