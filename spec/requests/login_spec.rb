require "rails_helper"

RSpec.describe "Google Authentication API", type: :request do
  describe "POST /api/v1/auth/google" do
    it "rejects a request without a Google credential" do
      post "/api/v1/auth/google",
           params: {},
           as: :json

      expect(response).to have_http_status(:bad_request)

      json = JSON.parse(response.body)
      expect(json["error"]).to eq("Google credential is required")
    end
  end

  describe "GET /api/v1/auth/me" do
    it "rejects unauthenticated requests" do
      get "/api/v1/auth/me",
          headers: { "Accept" => "application/json" }

      expect(response).to have_http_status(:unauthorized)

      json = JSON.parse(response.body)
      expect(json["error"]).to eq("Not authenticated")
    end
  end

  describe "DELETE /api/v1/auth/logout" do
    it "logs out successfully" do
      delete "/api/v1/auth/logout"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Logged out successfully")
    end
  end
end