require "rails_helper"

RSpec.describe CartItem, type: :model do
  describe "validations" do
    it "is valid with a positive quantity" do
      cart = Cart.create!

      product = Product.create!(
        name: "Test Mouse",
        price: 100,
        stock: 10
      )

      cart_item = CartItem.new(
        cart: cart,
        product: product,
        quantity: 2
      )

      expect(cart_item).to be_valid
    end

    it "is invalid with a quantity of zero" do
      cart = Cart.create!

      product = Product.create!(
        name: "Test Mouse",
        price: 100,
        stock: 10
      )

      cart_item = CartItem.new(
        cart: cart,
        product: product,
        quantity: 0
      )

      expect(cart_item).not_to be_valid
    end
  end
end