class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  before_validation :generate_token, on: :create

  validates :token, presence: true, uniqueness: true

  private

  def generate_token
    self.token ||= SecureRandom.hex(32)
  end
end