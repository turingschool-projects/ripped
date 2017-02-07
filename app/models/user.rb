class User < ApplicationRecord
  validates :census_id, presence: true

  has_many :solutions
  has_many :feedbacks

  enum role: [:student, :instructor]

  def instructor?
    role == "instructor"
  end
end
