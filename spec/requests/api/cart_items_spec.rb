require "rails_helper"

RSpec.describe "Cart items API", type: :request do
  let(:cart) { create(:cart) }

  let(:headers) do
    {
      "X-Cart-Token" => cart.token
    }
  end

  describe "POST /api/carts/:cart_id/cart_items" do
    it "adds a product to the cart" do
      product = Product.create!(
        name: "Test Mouse",
        price: 100,
        stock: 10
      )

      expect do
        post "/api/carts/#{cart.id}/cart_items",
             params: {
               cart_item: {
                 product_id: product.id,
                 quantity: 2
               }
             },
             headers: headers
      end.to change(CartItem, :count).by(1)

      expect(response).to have_http_status(:created)

      cart_item = CartItem.last
      expect(cart_item.product_id).to eq(product.id)
      expect(cart_item.quantity).to eq(2)
    end

    it "increases quantity when adding the same product again" do
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

      expect do
        post "/api/carts/#{cart.id}/cart_items",
             params: {
               cart_item: {
                 product_id: product.id,
                 quantity: 3
               }
             },
             headers: headers
      end.not_to change(CartItem, :count)

      cart_item = CartItem.find_by!(cart: cart, product: product)

      expect(response).to have_http_status(:created)
      expect(cart_item.reload.quantity).to eq(5)
    end
  end

  describe "PATCH /api/carts/:cart_id/cart_items/:id" do
    it "updates the cart item quantity" do
      product = Product.create!(
        name: "Test Mouse",
        price: 100,
        stock: 10
      )

      cart_item = CartItem.create!(
        cart: cart,
        product: product,
        quantity: 4
      )

      patch "/api/carts/#{cart.id}/cart_items/#{cart_item.id}",
            params: {
              cart_item: {
                quantity: 2
              }
            },
            headers: headers

      expect(response).to have_http_status(:ok)
      expect(cart_item.reload.quantity).to eq(2)
    end

    it "increases the quantity by one" do
      product = Product.create!(
        name: "Test Mouse",
        price: 100,
        stock: 10
      )

      cart_item = CartItem.create!(
        cart: cart,
        product: product,
        quantity: 2
      )

      patch "/api/carts/#{cart.id}/cart_items/#{cart_item.id}",
            params: {
              action_type: "increase"
            },
            headers: headers

      expect(response).to have_http_status(:ok)
      expect(cart_item.reload.quantity).to eq(3)
    end

    it "decreases the quantity by one" do
      product = Product.create!(
        name: "Test Mouse",
        price: 100,
        stock: 10
      )

      cart_item = CartItem.create!(
        cart: cart,
        product: product,
        quantity: 2
      )

      patch "/api/carts/#{cart.id}/cart_items/#{cart_item.id}",
            params: {
              action_type: "decrease"
            },
            headers: headers

      expect(response).to have_http_status(:ok)
      expect(cart_item.reload.quantity).to eq(1)
    end

    it "rejects quantity below one" do
      product = Product.create!(
        name: "Test Mouse",
        price: 100,
        stock: 10
      )

      cart_item = CartItem.create!(
        cart: cart,
        product: product,
        quantity: 1
      )

      patch "/api/carts/#{cart.id}/cart_items/#{cart_item.id}",
            params: {
              action_type: "decrease"
            },
            headers: headers

      expect(response).to have_http_status(:unprocessable_content)
      expect(cart_item.reload.quantity).to eq(1)
    end
  end

  describe "DELETE /api/carts/:cart_id/cart_items/:id" do
    it "removes the item without deleting the cart" do
      product = Product.create!(
        name: "Test Mouse",
        price: 100,
        stock: 10
      )

      cart_item = CartItem.create!(
        cart: cart,
        product: product,
        quantity: 2
      )

      expect do
        delete "/api/carts/#{cart.id}/cart_items/#{cart_item.id}",
               headers: headers
      end.to change(CartItem, :count).by(-1)

      expect(response).to have_http_status(:no_content)
      expect(Cart.exists?(cart.id)).to be(true)
    end
  end
end