# frozen_string_literal: true

# Authentication controller
class AuthenticationController < ApplicationController
  before_action :authenticate_user!, except: [:login]
  protect_from_forgery

  def login
    @user = User.where(email: params[:email]).first
    if @user&.valid_password?(params[:password])
      render json: { token: JsonWebToken.encode(user_id: @user.id),
                     exp: DateTime.current + 24.hours,
                     email: @user.email }, status: :ok
    else
      render json: { error: 'unauthorized',
                     valid_email: !@user.nil? },
             status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
