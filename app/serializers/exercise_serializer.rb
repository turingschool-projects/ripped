class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :name, :content, :description, :solutions
end
