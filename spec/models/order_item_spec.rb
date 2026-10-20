require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "validations" do
    let(:product) do
      Product.create!(
        name: "Mechanical Keyboard",
        price: 1500.00,
        stock: 10
      )
    end

    let(:order) do
      Order.create!(
        customer_name: "Juan Dela Cruz",
        customer_email: "juab@example.com",
        shipping_address: "Ormoc City, Leyte",
        total_amount: 3000.00
      )
    end

    it "is valid with valid attributes" do
      order_item = OrderItem.new(
        order: order,
        product: product,
        product_name: product.name,
        price: product.price,
        quantity: 2
      )

      expect(order_item).to be_valid
    end

    it "is invalid with a quantity of zero" do
      order_item = OrderItem.new(
        order: order,
        product: product,
        product_name: product.name,
        price: product.price,
        quantity: 0
      )

      expect(order_item).not_to be_valid
    end
  end
end
