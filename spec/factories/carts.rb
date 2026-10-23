FactoryBot.define do
  factory :cart do
    association :user
    token { SecureRandom.hex(32) }
  end
end