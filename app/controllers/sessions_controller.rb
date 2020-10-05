# frozen_string_literal: true

# Session controller
class SessionsController < ApplicationController
  include CurrentUserConcern

  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      render json: {
        logged_in: true,
        user: user.attributes.merge({ institution: user.institution })
        }, status: :created
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def logged_in
    if @current_user
      render json: {
        logged_in: true,
        user: @current_user.attributes.merge({ 
              institution: @current_user.institution_id && Institution.find(@current_user.institution_id) })
              .as_json(except: %i[created_at updated_at])
      }
    else
      render json: {
        logged_in: false
      }
    end
  end

  def logout
    reset_session
    render json: { logged_out: true }, status: :ok
  end
end
