# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  include CurrentUserConcern

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

  def show_by_email
    @user = User.find_by(email: params[:email])

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

  def update
    @user = User.find params[:id]

    @user.update!(user_params)

    render json: { user: @user.as_json(except: %i[created_at updated_at]) },
           status: :created
  end

  def destroy
    # Related to: institutions, answers, questions, channels, messages, user_question_votes, user_answer_votes, user_institution_invitations, user_saved_questions
    @user = User.find params[:id]
  end

  def clear_institution
    if @current_user
      institution = Institution.find(params[:institution_id])

      if institution.creator.id == @current_user.id
        render json: { errors: 'cannot remove creator' },
                status: :unprocessable_entity
      else 
        # Update user institution id
        @current_user.update!(institution_id: nil)
        render json: { hasRemovedUser: true },
                status: :created
      end
    else
      render json: { errors: 'unauthorized' },
              status: :unauthorized
    end
  end

  def accept_invitation
    invitation = UserInstitutionInvitation.find params[:invitation_id]
    if @current_user.id == invitation.user_id
      @current_user.update!(institution_id: invitation.institution_id, reputation: @current_user.reputation + 5)
      # Once accepted, delete all the invitations involving the user
      @current_user.invitations.destroy_all

      render json: { hasAcceptedInvitation: true },
                status: :created
    else
      render json: { errors: 'unauthorized' },
              status: :unauthorized
    end
  end

  def reject_invitation
    invitation = UserInstitutionInvitation.find params[:invitation_id]
    if @current_user.id == invitation.user_id
      invitation.destroy
      render json: { hasRejectedInvitation: true },
                status: :created
    else
      render json: { errors: 'unauthorized' },
              status: :unauthorized
    end
  end

  def show_user_invitations
    if @current_user
      invitations = @current_user.invitations.map do |invitation|
        institution = Institution.find invitation.institution_id
        invitation.attributes.merge({ institution_name: institution.name })
      end
      render json: invitations.as_json, status: :ok
    else
      render json: { errors: 'unauthorized' },
              status: :unauthorized
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
