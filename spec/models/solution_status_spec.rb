require 'rails_helper'

RSpec.describe Solution, type: :model do
  describe "statuses" do
    it { should define_enum_for(:status).with([:submitted, :solved])}
    it "is created with status submitted" do
      exercise = create(:exercise)
      solution = Solution.create(content: "solution name", exercise_id: exercise.id)
      expect(solution.status).to eq("submitted")
    end
    it "can have status solved" do
      exercise = create(:exercise)
      solution = Solution.create(content: "solution name", exercise_id: exercise.id)
      solution.status = 1
      expect(solution.status).to eq("solved")
    end
  end
end