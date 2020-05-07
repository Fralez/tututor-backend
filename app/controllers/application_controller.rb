# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  acts_as_token_authentication_handler_for User, fallback: :none, except: [:create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[identity_number name gender birth_date])
  end
end
