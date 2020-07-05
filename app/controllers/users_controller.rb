# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  def index
    render json: User.all.as_json(except: %i[created_at updated_at]), status: :ok
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user
      render json: { user: @user.as_json(except: %i[created_at updated_at]) }, status: :ok
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

  # @current_user = get_current_user

  # user_vars = nil
  # if @current_user.present?
  #   user_vars = {
  #     has_voted: UserQuestionVote.where(user_id: @current_user.id, question_id: @question.id).last.present?,
  #     has_saved_question: UserSavedQuestion.where(user_id: @current_user.id, question_id: @question.id).last.present?
  #   }
  # end

  private

  def user_params
    params.require(:user).permit(
      :email, :password, :identity_number, :name,
      :gender, :birth_date
    )
  end
end
