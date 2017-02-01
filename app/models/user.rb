class User < ApplicationRecord
  validates :census_id, presence: true
end
