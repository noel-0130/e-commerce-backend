class ApplicationMailer < ActionMailer::Base
  default from: -> { "Noel Shop <#{ENV.fetch('GMAIL_SENDER', 'no-reply@example.com')}>" }
  layout "mailer"
end