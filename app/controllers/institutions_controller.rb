class InstitutionsController < ApplicationController
  def index
    institutions = Institution.all
    render json: institutions.as_json, status: :ok
  end

  def show
    institution = Institution.find(params[:id])
    if institution
      render json: { institution: institution },
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
        render json: { institution: institution.as_json },
               status: :created
      else
        render json: { errors: institution.errors.full_messages },
               status: :unprocessable_entity
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
