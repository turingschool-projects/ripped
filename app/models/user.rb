class User < ApplicationRecord
  validates :census_id, presence: true

  has_many :solutions
  has_many :feedbacks

  enum role: [:student, :instructor]

  def instructor?
    role == "instructor"
  end
  
  def student?
    role == "student"
  end
  
  def notification_display
    if instructor?
      notifier_count = Solution.where(status: 0).count
    else
      notifier_count = Solution.where(status: 1).count
    end
    notifier_count
  end
end
