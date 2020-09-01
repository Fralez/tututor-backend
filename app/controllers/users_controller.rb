# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  def index
    render json: User.all.as_json(except: %i[created_at updated_at]), status: :ok
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user
      render json: { user: @user.attributes.merge({ 
                     institution: @user.institution_id && Institution.find(@user.institution_id) })
                     .as_json(except: %i[created_at updated_at]) },
                     status: :ok
    else
      not_found
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { user: @user.as_json(except: %i[created_at updated_at]) },
             status: :created
    elsif User.exists?(email: @user.email) || User.exists?(identity_number: @user.identity_number)
      render json: { errors: 'email or identity_number already registered' },
             status: :bad_request
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :password, :identity_number, :name,
      :gender, :birth_date
    )
  end
end
