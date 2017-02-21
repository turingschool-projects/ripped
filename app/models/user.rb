class User < ApplicationRecord
  validates :census_id, presence: true

  has_many :solutions
  has_many :feedbacks

  enum role: [:student, :instructor]

  def census_name(token)
    profile = Profile.find_user(token, self.census_id)
    name = "#{profile.first_name} #{profile.last_name}"
  end

  def census_cohort(token)
    profile = Profile.find_user(token, self.census_id)
    cohort = profile.cohort
  end

  def instructor?
    role == "instructor"
  end

  def student?
    role == "student"
  end
  attr_reader :notification_display, :solution_display, :count

  def notification_display(current_user)
    if instructor?
      notifier_count = find_uncommented_solution_count
      display_info = instructor_notifier_count_handler(notifier_count)
    else
      notifier_count = find_solutions_with_new_comments_count(current_user)
      display_info = student_notifier_count_handler(notifier_count)
    end
    display_info
  end

  def instructor_notifier_count_handler(notifier_count)
    if notifier_count == 0
      "Recent Updates: None"
    elsif notifier_count == 1
      "1 Solution Needs Feedback"
    else
      notifier_count.to_s + " Solutions Need Feedback"
    end
  end

  def student_notifier_count_handler(notifier_count)
    if notifier_count == 0
      "No Unread Feedback"
    elsif notifier_count == 1
      "1 Unread Feedback"
    else
      notifier_count.to_s + " Unread Feedbacks"
    end
  end

  def solution_display(current_user)
    if current_user.role == "student"
      results = Solution.where(user_id: current_user.id, status: 1)
    else
      results = Solution.where(status: 0)
    end
    results
  end
  
  def find_uncommented_solution_count
    solutions = Solution.all
    uncommented_solutions = []
    solutions.each do |solution|
      if solution.feedbacks.empty?
        uncommented_solutions << solution
      end
      uncommented_solutions
    end
    count = uncommented_solutions.count
  end
  
  def find_solutions_with_new_comments_count(current_user)
    solutions = Solution.where(user_id: current_user.id)
    commented_solutions = 0
    solutions.each do |solution|
      commented_solutions += filter_feedbacks_for_solution(solution)
    end
    commented_solutions
  end
  
  def filter_feedbacks_for_solution(solution)
    feedbacks_that_need_to_be_read = []
    solution.feedbacks.each do |feedback|
      if feedback.status = "unread"
        feedbacks_that_need_to_be_read << feedback
      end
      feedbacks_that_need_to_be_read
    end
    feedbacks_that_need_to_be_read.count
  end
end
