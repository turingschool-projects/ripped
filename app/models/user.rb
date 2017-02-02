class User < ApplicationRecord
  validates :census_id, presence: true

  has_many :solutions
end
