require 'rails_helper'

RSpec.describe Solution, type: :model do
  describe "validations" do
    it "is invalid without a solution content" do
      user = create(:user)
      exercise = create(:exercise)
      solution = Solution.create(user_id: user.id, exercise_id: exercise.id)
      expect(solution).to_not be_valid
    end
    it "is invalid without a user" do
      exercise = create(:exercise)
      solution = Solution.create(content: "solution name", exercise_id: exercise.id)
      expect(solution).to_not be_valid
    end
    it "is invalid without an exercises" do
      user = create(:user)
      solution = Solution.create(content: "solution name", user_id: user.id)
      expect(solution).to_not be_valid
    end
    it "is valid with all attributes" do
      user = create(:user)
      exercise = create(:exercise)
      solution = Solution.create(content: "solution name", user_id: user.id, exercise_id: exercise.id)
      expect(solution).to be_valid
    end
  end
end
