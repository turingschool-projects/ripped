class SolutionWithUnreadFeedbackSerializer < ActiveModel::Serializer
  attributes :id, :content, :exercise_id, :feedbacks
  has_one :exercise
  
  def feedbacks
    object.feedbacks.where(status: "unread")
  end
end
