class Exercise < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :description, presence: true
  # validates :tags, presence: true

  has_many :solutions
  has_many :exercise_tags
  has_many :tags, through: :exercise_tags

end
