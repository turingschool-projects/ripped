class ExerciseTag < ApplicationRecord

  belongs_to :exercise, required: true
  belongs_to :tag, required: true

end
