require "rails_helper"

RSpec.describe "Cart items API", type: :request do
  describe "POST /api/carts/:cart_id/cart_items" do
    it "add a product to the cart" do
      cart = Cart.create!
      product = Product.create!(
        name: "Test Mouse",
        price: 100,
        stock: 10
      )

      expect {
        post "/api/carts/#{cart.id}/cart_items", 
        params: {
          cart_item: {
            product_id: product.id,
            quantity: 2
          }
        }
      }.to change(CartItem, :count).by(1)

      expect(response).to have_http_status(:created)

      cart_item = CartItem.last
      expect(cart_item.product_id).to eq(product.id)
      expect(cart_item.quantity).to eq(3)
    end
  end
end