require "net/http"
require "json"
require "base64"

class GmailApiDelivery
  TOKEN_URL = URI("https://oauth2.googleapis.com/token")
  SEND_URL  = URI("https://gmail.googleapis.com/gmail/v1/users/me/messages/send")

  def initialize(_settings = {}); end

  def deliver!(mail)
    raw = Base64.urlsafe_encode64(mail.encoded, padding: false)

    http = Net::HTTP.new(SEND_URL.host, SEND_URL.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(
      SEND_URL,
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{access_token}"
    )
    request.body = { raw: raw }.to_json

    response = http.request(request)
    unless response.is_a?(Net::HTTPSuccess)
      raise "Gmail API error #{response.code}: #{response.body}"
    end
    response
  end

  private

  def access_token
    response = Net::HTTP.post_form(
      TOKEN_URL,
      "client_id" => ENV.fetch("GOOGLE_CLIENT_ID"),
      "client_secret" => ENV.fetch("GOOGLE_CLIENT_SECRET"),
      "refresh_token" => ENV.fetch("GOOGLE_REFRESH_TOKEN"),
      "grant_type" => "refresh_token"
    )
    unless response.is_a?(Net::HTTPSuccess)
      raise "Gmail token error #{response.code}: #{response.body}"
    end
    JSON.parse(response.body).fetch("access_token")
  end
end

ActionMailer::Base.add_delivery_method :gmail_api, GmailApiDelivery