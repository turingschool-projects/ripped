class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :exercise_tags, dependent: :destroy
  has_many :exercises, through: :exercise_tags

end
