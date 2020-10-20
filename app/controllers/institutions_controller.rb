class InstitutionsController < ApplicationController
  def index
    institutions = Institution.all.map do |insti|

      insti.attributes.merge({ creator: insti.creator })
    end
    render json: institutions.as_json, status: :ok
  end

  def show
    institution = Institution.find(params[:id])
    if institution
      render json: { institution: institution.attributes.merge({ creator: institution.creator }) },
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

  def clear_user_institution
    if @current_user
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
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def update_creator
    if @current_user
      institution = Institution.find(params[:institution_id])
      user = User.find(params[:new_creator_user_id])

      if user.nil?
        render json: { errors: 'null user' },
                status: :unprocessable_entity
      elsif user.institution_id != institution.id
        render json: { errors: 'user not belongs to institution' },
                status: :unprocessable_entity
      else
        institution.creator = user
        render json: { hasUpdatedCreator: true },
               status: :created
      end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def institution_params
    params.require(:institution).permit(:name, :email, :description, :address)
  end
end
