require "rails_helper"

RSpec.describe Order, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      order = Order.new(
        customer_name: "Juan Dela Cruz",
        customer_email: "juan@example.com",
        shipping_address: "Ormoc City, Leyte",
        total_amount: 3000.00
      )

      expect(order).to be_valid
    end

    it "is invalid without a customer name" do
      order = Order.new(
        customer_name: nil,
        customer_email: "juan@example.com",
        shipping_address: "Ormoc City, Leyte",
        total_amount: 3000.00
      )

      expect(order).not_to be_valid
    end
  end
end