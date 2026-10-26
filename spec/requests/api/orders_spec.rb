require "rails_helper"

RSpec.describe "Orders API", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  def create_order(owner, name: "Mouse")
    product = Product.create!(name: name, price: 100, stock: 10)

    order = Order.create!(
      user: owner,
      customer_name: "Juan",
      customer_email: owner.email,
      shipping_address: "Ormoc City",
      total_amount: 200
    )

    order.order_items.create!(
      product: product,
      product_name: name,
      price: 100,
      quantity: 2
    )

    order
  end

  context "when logged in" do
    before do
      allow_any_instance_of(Api::OrdersController)
        .to receive(:session).and_return({ user_id: user.id })
    end

    it "lists only the current user's orders" do
      mine = create_order(user)
      create_order(other_user, name: "Keyboard")

      get "/api/orders"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.length).to eq(1)
      expect(json[0]["id"]).to eq(mine.id)
      expect(json[0]["items"][0]["name"]).to eq("Mouse")
    end

    it "does not show another user's order" do
      theirs = create_order(other_user)

      get "/api/orders/#{theirs.id}"

      expect(response).to have_http_status(:not_found)
    end
  end

  context "when not logged in" do
    it "returns unauthorized" do
      get "/api/orders"

      expect(response).to have_http_status(:unauthorized)
    end
  end
end