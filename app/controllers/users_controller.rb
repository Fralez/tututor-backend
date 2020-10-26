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
                     institution: @user.institution, 
                     saved_questions: @user.saved_questions })
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

  def users_without_institution
    render json: User.where(institution_id: nil).all.order(name: :asc).as_json(except: %i[created_at updated_at]), status: :ok
  end

  def clear_institution
    institution = Institution.find(params[:institution_id])
    user = User.find(params[:user_id])

    if user.nil?
      render json: { errors: 'null user' },
              status: :unprocessable_entity
    elsif institution.creator.id == user.id
      render json: { errors: 'cannot remove creator' },
              status: :unprocessable_entity
    else 
      # Update user institution id
      user.update!(institution_id: nil)
      render json: { hasRemovedUser: true },
              status: :created
    end
  end

  def show_user_invitations
    render json: {}, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :password, :identity_number, :name,
      :gender, :birth_date
    )
  end
end
