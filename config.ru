# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

use Rack::Cors do
  allow do
    origins 'https://tututor-client.vercel.app'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end

  allow do
    origins 'https://tututor-client.herokuapp.com/'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end

run Rails.application
