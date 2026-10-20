require "rails_helper"

RSpec.describe "API::Checkouts", type: :request do
  let (:product) do
    Product.create!(
      name: "Mechanical Keyboard",
      description: "Gaming Keyboard",
      price: 1500.00,
      stock: 10
    )
  end
  
  let(:cart) { Cart.create! }

  let!(:cart_item) do
    CartItem.create!(
      cart: cart,
      product: product,
      quantity: 2
    )
  end

  describe "POST /api/carts/:cart_id/checkout" do
    let(:checkout_params) do
      {
        customer_name: "Juan Dela Cruz",
        customer_email: "juan@example.com",
        shipping_address: "Ormoc City, Leyte"
      }
    end

    let(:headers) do
      {
        "X-Cart-Token" => cart.token
      }
    end
    
    it "create an order successfully" do
      post "/api/carts/#{cart.id}/checkout",
          params: checkout_params,
          headers: headers

      expect(response).to have_http_status(:created)

      puts response.status
      puts response.body

      json = JSON.parse(response.body)

      expect(json["message"]).to eq("Checkout successful")
      expect(json["status"]).to eq("pending")
      expect(json["total_amount"].to_f).to eq(3000.00)
    end

    it "deduct product stock after checkout" do
      expect {
        post "/api/carts/#{cart.id}/checkout", params: checkout_params, headers: headers
      }.to change{ product.reload.stock }.from(10).to(8)

      expect(response).to have_http_status(:created)
    end

    it "creates order items after checkout" do
      expect {
        post "/api/carts/#{cart.id}/checkout", params: checkout_params, headers: headers
      }.to change(OrderItem, :count).by(1)

      expect(response).to have_http_status(:created)

      order_item = OrderItem.last

      expect(order_item.product_name).to eq("Mechanical Keyboard")

      expect(order_item.price).to eq(1500.00)

      expect(order_item.quantity).to eq(2)
    end

    it "clears the cart after checkout" do
      expect {
        post "/api/carts/#{cart.id}/checkout", params: checkout_params, headers: headers
      }.to change(CartItem, :count).by(-1)

      expect(response).to have_http_status(:created)

      expect(cart.reload.cart_items).to be_empty
    end

    it "rejects checkout when stock is insufficient" do
      product.update!(stock: 1)

      post "/api/carts/#{cart.id}/checkout", params: checkout_params, headers: headers

      expect(response).to have_http_status(:unprocessable_content)

      expect(Order.count).to eq(0)

      expect(product.reload.stock).to eq(1)

      expect(cart.reload.cart_items.count).to eq(1)
    end

    it "rejects checkout when cart is empty" do
      cart.cart_items.destroy_all

      expect {
        post "/api/carts/#{cart.id}/checkout", params: checkout_params, headers: headers
      }.not_to change(Order, :count)

      expect(response).to have_http_status(:unprocessable_content)

      json = JSON.parse(response.body)

      expect(json["error"]).to eq("Cart is empty")
    end

    it "reject checkout when customer information is missing" do
      invalid_params = checkout_params.except(:customer_name)

      expect {
        post "/api/carts/#{cart.id}/checkout",
        params: invalid_params,
        headers: headers
      }.not_to change(Order, :count)

      expect(response).to have_http_status(:unprocessable_content)
    end

    it "rejects checkout with an invalid token" do
      invalid_headers = {
        "X-Cart-Token" => "invalid_token"
      }

      expect {
        post "/api/carts/#{cart.id}/checkout",
        params: checkout_params,
        headers: invalid_headers
      }.not_to change(Order, :count)

      expect(response).to have_http_status(:not_found)
    end

    it "rolls back checkout when order item creation fails" do
      allow_any_instance_of(Order).to receive(:order_items).and_raise(
        ActiveRecord::RecordInvalid.new(Order.new)
      )

      expect {
        post "/api/carts/#{cart.id}/checkout",
            params: checkout_params,
            headers: headers
      }.not_to change(Order, :count)

      expect(response).to have_http_status(:unprocessable_content)
      expect(product.reload.stock).to eq(10)
      expect(cart.reload.cart_items.count).to eq(1)
    end
  end
end