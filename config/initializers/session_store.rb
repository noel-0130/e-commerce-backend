Rails.application.config.session_store(
  :active_record_store,
  key: "_noelshop_session",
  same_site: Rails.env.production? ? :none : :lax,
  httponly: true,
  secure: Rails.env.production?
)

# Ang API-only app ay walang session middleware kaya idagdag natin dito.
Rails.application.config.middleware.use(
  Rails.application.config.session_store,
  Rails.application.config.session_options
)