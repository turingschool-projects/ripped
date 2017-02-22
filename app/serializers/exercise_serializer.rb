class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :name, :content, :description, :solutions
  has_many :solutions
end
