class UserMailer < ApplicationMailer
  def verify_email(user)
    @user = user
    token = user.generate_token_for(:email_verification)
    @url = "#{ENV.fetch('API_URL')}/api/v1/auth/verify_email?token=#{token}"

    mail(to: user.email, subject: "I-verify ang email mo")
  end
end