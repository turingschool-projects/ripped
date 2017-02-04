class Exercise < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :description, presence: true

  has_many :solutions
end
