require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe "validations" do
    it "is invalid without a name" do
      tag = create(:tag)
      exercise = Exercise.create(content: "exercise content", description: "exercise description")
      exercise.tags = [tag]
      expect(exercise).to_not be_valid
    end
    it "is invalid without content" do
      tag = create(:tag)
      exercise = Exercise.create(name: "exercise name", description: "exercise description")
      exercise.tags = [tag]
      expect(exercise).to_not be_valid
    end
    it "is invalid without a description" do
      tag = create(:tag)
      exercise = Exercise.create(name: "exercise name", content: "exercise content")
      exercise.tags = [tag]
      expect(exercise).to_not be_valid
    end
    it "is invalid without a tag" do
      exercise = Exercise.create(name: "exercise name", content: "exercise content", description: "exercise description")
      expect(exercise).to be_invalid
    end
    it "is valid with all attributes" do
      tag = create(:tag)
      exercise = Exercise.create(name: "exercise name", content: "exercise content", description: "exercise description")
      exercise.tags = [tag]
      expect(exercise).to be_valid
    end
  end
  describe "relationships" do
    it "has many solutions" do
      exercise = create(:exercise)
      expect(exercise).to respond_to(:solutions)
    end
    it "has many exercise_tags" do
      exercise = create(:exercise)
      expect(exercise).to respond_to(:exercise_tags)
    end
    it "has many tags" do
      exercise = create(:exercise)
      expect(exercise).to respond_to(:tags)
    end
  end
end
