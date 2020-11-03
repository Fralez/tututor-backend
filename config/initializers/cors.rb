# CORS support
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  if Rails.env != 'production'
    allow do
      origins 'http://localhost:8080'
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    end
  end
  
  allow do
    origins 'https://tututor-client.vercel.app'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end