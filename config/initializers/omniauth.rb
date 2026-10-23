require "omniauth/rails_csrf_protection"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :google_oauth2,
    ENV.fetch("GOOGLE_CLIENT_ID"),
    ENV.fetch("GOOGLE_CLIENT_SECRET"),
    {
      scope: "email,profile",
      prompt: "select_account"
    }
  )
end