class InstitutionsController < ApplicationController
  include CurrentUserConcern

  def index
    institutions = Institution.all.map do |insti|

      insti.attributes.merge({ creator: insti.creator })
    end
    render json: institutions.as_json, status: :ok
  end

  def show
    institution = Institution.find(params[:id])
    if institution
      render json: { institution: institution.attributes.merge({ creator: institution.creator, users: institution.users }) },
             status: :ok
    else
      not_found
    end
  end

  def create
    if @current_user
      institution = Institution.new(institution_params.merge(creator_id: @current_user.id))

      if institution.save
        @current_user.update!(institution_id: institution.id)
        render json: { institution: institution.attributes.merge({ creator: institution.creator }) },
               status: :created
      else
        render json: { errors: institution.errors.full_messages },
               status: :unprocessable_entity
      end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def update_creator
    institution = Institution.find(params[:institution_id])

    if @current_user.id == institution.creator.id
      user = User.find(params[:new_creator_user_id])

      if user.nil?
        render json: { errors: 'null user' },
                status: :unprocessable_entity
      elsif user.institution_id != institution.id
        render json: { errors: 'user not belongs to institution' },
                status: :unprocessable_entity
      else
        institution.update!(creator_id: user.id)
        render json: { hasUpdatedCreator: true },
                status: :created
      end
    else
      render json: { errors: 'unauthorized' },
              status: :unauthorized
    end
  end

  def create_invitation
    institution = Institution.find params[:institution_id]

    if @current_user.id == institution.creator.id
      user = User.find params[:user_id]
      invitation = UserInstitutionInvitation.create!(user_id: user.id, institution_id: institution.id)

      render json: { invitation: invitation }, status: :created
    else
      render json: { errors: 'unauthorized' },
              status: :unauthorized
    end
  end

  private

  def institution_params
    params.require(:institution).permit(:name, :email, :description, :address)
  end
end
