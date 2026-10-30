class User < ApplicationRecord
  has_secure_password validations: false

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :nullify

  before_validation { self.email = email.to_s.strip.downcase }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :google_uid, uniqueness: true, allow_nil: true
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validate :google_or_password_present

  generates_token_for :email_verification, expires_in: 24.hours do
    [email, email_verified_at]
  end

  def email_verified?
    email_verified_at.present?
  end

  def verify_email!
    update!(email_verified_at: Time.current)
  end

  private

  def google_or_password_present
    return if google_uid.present? || password_digest.present?

    errors.add(:password, "can't be blank")
  end
end