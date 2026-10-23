Rails.application.config.session_store(
  :active_record_store,
  key: "_shopease_session",
  same_site: :lax,
  httponly: true,
  secure: Rails.env.production?
)