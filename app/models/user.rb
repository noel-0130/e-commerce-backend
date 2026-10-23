class User < ApplicationRecord
  has_one :cart, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :google_uid, presence: true, uniqueness: true
end