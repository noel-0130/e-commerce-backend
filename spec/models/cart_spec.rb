require "rails_helper"

RSpec.describe Cart, type: :model do
  describe "associations" do
    it "has many cart items" do
      association = described_class.reflect_on_association(:cart_items)

      expect(association.macro).to eq(:has_many)
    end
  end
end