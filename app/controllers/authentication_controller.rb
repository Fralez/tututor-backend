# frozen_string_literal: true

# Authentication controller
class AuthenticationController < ApplicationController
  before_action :authorize_request, except: [:login]
  protect_from_forgery

  def login
    @user = User.where(email: params[:email]).first
    if @user&.valid_password?(params[:password])
      render json: { token: JsonWebToken.encode(user_id: @user.id),
                     exp: DateTime.current + 24.hours,
                     email: @user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def renew
    @token = request.headers['Authorization'].split(' ').last
    token_data = JsonWebToken.renew @token
    render json: token_data
  end
end
