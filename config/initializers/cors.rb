Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    allowed_origins = ENV.fetch("ALLOWED_ORIGINS", "http://localhost:5173")
                         .split(",")
                         .map(&:strip)
                         .reject(&:empty?)

    origins(*allowed_origins, /\.app\.github\.dev$/)

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end