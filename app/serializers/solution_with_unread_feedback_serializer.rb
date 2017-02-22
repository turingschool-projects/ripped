class SolutionWithUnreadFeedback < ActiveModel::Serializer
  attributes :id, :content, :exercise_id, :feedbacks
  has_one :exercise
  has_many :feedbacks
end
