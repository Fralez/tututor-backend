# CORS support
if Rails.env == 'production'
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://tututor-client.vercel.app'
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    end

    allow do
      origins 'https://tututor-client.herokuapp.com'
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    end
  end
else
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:8080'
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    end
  end
end