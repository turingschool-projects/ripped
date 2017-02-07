class Feedback < ApplicationRecord
  validates :comment, presence: true
  validates :user_id, presence: true
  validates :solution_id, presence: true
  
  belongs_to :user
  belongs_to :solution
end
