require 'rails_helper'

RSpec.describe Solution, type: :model do
  describe "statuses" do
    it { should define_enum_for(:status).with([:Submitted, :Solved])}
    it "is created with status Submitted" do
      exercise = create(:exercise)
      solution = Solution.create(content: "solution name", exercise_id: exercise.id)
      expect(solution.status).to eq("Submitted")
    end
    it "can have status Solved" do
      exercise = create(:exercise)
      solution = Solution.create(content: "solution name", exercise_id: exercise.id)
      solution.status = 1
      expect(solution.status).to eq("Solved")
    end
  end
end