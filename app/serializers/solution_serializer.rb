class SolutionSerializer < ActiveModel::Serializer
  attributes :id, :content, :exercise_id
  has_one :exercise
end
