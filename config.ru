# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

use Rack::Cors do
  allow do
    origins 'https://tututor-client.vercel.app'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end

Rails.application.config.hosts << "https://tututor-client.vercel.app"
Rails.application.config.hosts <<  "https://tututor-backend.herokuapp.com"

Rails.application.config.session_store :cookie_store, key: "_tututor_session_store", domain: "https://tututor-backend.herokuapp.com"


run Rails.application
