class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :solution_id, :comment, :created_at, :updated_at, :status
end
