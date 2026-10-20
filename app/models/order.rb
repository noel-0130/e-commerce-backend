class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  validates :customer_name, presence: true
  validates :customer_email, presence: true
  validates :shipping_address, presence: true
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
end
