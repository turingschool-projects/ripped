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
  
  attr_reader :notification_display, :solution_display
  
  def notification_display(current_user)
    if instructor?
      notifier_count = Solution.where(status: 0).count
    else
      notifier_count = (Solution.where(user_id: current_user.id, status: 1)).count
    end
    notifier_count_handler(notifier_count)
  end
  
  def notifier_count_handler(notifier_count)
    if notifier_count == 0
      "Recent Updates: None"
    elsif notifier_count == 1
      "Recent Updates: 1"
    else
      "Recent Updates: " + notifier_count.to_s
    end
  end
  
  def solution_display(current_user)
    if current_user.role == 0
      results = Solution.where(user_id: current_user.id, status: 1)
    else 
      results = Solution.where(status: 0)
    end
    results
  end
  
end
