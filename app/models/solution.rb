class Solution < ApplicationRecord
  validates :user_id, presence: true
  validates :exercise_id, presence: true
  validates :content, presence: true
  
  belongs_to :user
  belongs_to :exercise
end
