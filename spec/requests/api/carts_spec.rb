require "rails_helper"

RSpec.describe "Carts API", type: :request do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }

  let(:headers) do
    {
      "X-Cart-Token" => cart.token
    }
  end

  describe "POST /api/carts" do
    it "creates a new cart" do
      user

      expect do
        post "/api/carts"
      end.to change(Cart, :count).by(1)

      expect(response).to have_http_status(:created)

      json = JSON.parse(response.body)

      expect(json["id"]).to be_present
      expect(json["token"]).to be_present
    end
  end

  describe "GET /api/carts/:id" do
    it "returns cart details with item and total" do
      product = Product.create!(
        name: "Test Mouse",
        price: 100,
        stock: 10
      )

      CartItem.create!(
        cart: cart,
        product: product,
        quantity: 2
      )

      get "/api/carts/#{cart.id}", headers: headers

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["id"]).to eq(cart.id)
      expect(json["items"].length).to eq(1)
      expect(json["items"][0]["name"]).to eq("Test Mouse")
      expect(json["items"][0]["quantity"]).to eq(2)
      expect(json["total"].to_f).to eq(200)
    end
  end
end