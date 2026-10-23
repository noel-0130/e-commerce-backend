class SeedRun < ApplicationRecord
  validates :seed_name, presence: true, uniqueness: true
end