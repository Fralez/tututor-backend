# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  before_action :authorize_request, except: [:create]
  protect_from_forgery

  def index
    render json: User.all.as_json(except: %i[]), status: :ok
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user
      render json: { user: @user }, status: :ok
    else
      not_found
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :identity_number, :name,
      :gender, :birth_date
    )
  end
end
