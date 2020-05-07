# frozen_string_literal: true

# Authentication controller
class AuthenticationController < ApplicationController
  protect_from_forgery

  def login
    @user = User.where(email: params[:email]).first

    if @user&.valid_password?(params[:password])
      render json: @user.as_json(only: %i[email authentication_token]),
             status: :ok
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
