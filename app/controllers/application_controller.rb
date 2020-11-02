# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :add_allow_credentials_headers

  def not_found
    render json: { errors: 'Not found' }, status: :not_found
  end

  protected
  def add_allow_credentials_headers
    response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || 'https://tututor-client.vercel.app' # the domain you're making the request from
  end
end
