require 'rails_helper'

RSpec.describe ExerciseTag, type: :model do
  describe "validations" do
    it "is invalid without an exercise id" do
      tag = create(:tag)
      exercise_tag = ExerciseTag.create(tag_id: tag.id)
      expect(exercise_tag).to be_invalid
    end

    it "is invalid without a tag id" do
      exercise = create(:exercise)
      exercise_tag = ExerciseTag.create(exercise_id: exercise.id)
      expect(exercise_tag).to be_invalid
    end

    it "is valid with all attributes" do
      exercise = create(:exercise)
      tag = create(:tag)
      exercise_tag = ExerciseTag.create(exercise_id: exercise.id, tag_id: tag.id)
      expect(exercise_tag).to be_valid
    end
  end

  describe "relationships" do
    it "belongs to a tag" do
      exercise_tag = create(:exercise_tag)
      expect(exercise_tag).to respond_to(:tag)
    end
    it "belongs to an exercise" do
      exercise_tag = create(:exercise_tag)
      expect(exercise_tag).to respond_to(:exercise)
    end
  end
end
