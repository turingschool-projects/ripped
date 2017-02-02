require 'rails_helper'

RSpec.describe Solution, type: :model do
  describe "validations" do
    it "is invalid without a solution content" do
      exercise = create(:exercise)
      solution = Solution.create(exercise_id: exercise.id)
      expect(solution).to_not be_valid
    end
    it "is invalid without an exercise" do
      solution = Solution.create(content: "solution name",)
      expect(solution).to_not be_valid
    end
    it "is valid with all attributes" do
      exercise = create(:exercise)
      solution = Solution.create(content: "solution name", exercise_id: exercise.id)
      expect(solution).to be_valid
    end
  end
  describe "relationships" do
    it "belongs to an exercise" do
      solution = create(:solution)
      expect(solution).to respond_to(:exercise)
    end
  end
end
