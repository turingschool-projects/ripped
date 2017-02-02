class Exercise < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  has_many :solutions
end
