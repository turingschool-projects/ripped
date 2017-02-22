class SolutionWithUnreadFeedbackSerializer < ActiveModel::Serializer
  attributes :id, :content, :exercise_id, :feedbacks_unread
  has_one :exercise
  
  def feedbacks_unread
    object.feedbacks.where(status: "unread")
  end
end
