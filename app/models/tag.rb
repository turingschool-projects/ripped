class Tag < ApplicationRecord
  validates :name, presence: true

  has_many :exercises, through: :exercise_tags
end
