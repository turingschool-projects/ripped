class Exercise < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :description, presence: true
  validates :tags, presence: true

  has_many :solutions
  has_many :exercise_tags, dependent: :destroy
  has_many :tags, through: :exercise_tags

  enum status: [:published, :unpublished]

  def user_solution?(user)
    solutions.where(user: user).count > 0
  end

  def tag_names
    tags.map(&:name)
  end

  def tag_names=(tags)
    self.tags = tags.map do |tag|
      Tag.where('lower(name) = ?', tag.downcase).first_or_initialize
    end
  end

end
