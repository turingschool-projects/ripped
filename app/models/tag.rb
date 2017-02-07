class Tag < ApplicationRecord
  validates :name, presence: true

  has_many :exercise_tags
  has_many :exercises, through: :exercise_tags

end
