class Feedback < ApplicationRecord
  validates :comment, presence: true
  validates :user_id, presence: true
  validates :solution_id, presence: true

  belongs_to :user
  belongs_to :solution
  
  enum status: [:unread, :read]

  def time_posted_or_updated
    if self.created_at == self.updated_at
      self.created_at
    else
      self.updated_at
    end
  end
end
