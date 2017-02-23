require 'rails_helper'

RSpec.describe Solution, type: :model do
  describe "validations" do
    it "is invalid without a solution content" do
      exercise = create(:exercise)
      solution = Solution.create(exercise_id: exercise.id, content: "solution name")
      expect(solution).to_not be_valid
    end
    it "is invalid without an exercise id" do
      user = create(:user)
      solution = Solution.create(content: "solution name", user_id: user.id)
      expect(solution).to_not be_valid
    end

    it "is invalid without a user id" do
      exercise = create(:exercise)
      solution = Solution.create(content: "solution name", exercise_id: exercise.id)
      expect(solution).to_not be_valid
    end

    it "is valid with all attributes" do
      exercise = create(:exercise)
      user = create(:user)
      solution = Solution.create(content: "solution name", user_id: user.id, exercise_id: exercise.id)
      expect(solution).to be_valid
    end
  end

  describe "relationships" do
    it "belongs to an exercise" do
      solution = create(:solution)
      expect(solution).to respond_to(:exercise)
    end

    it "belongs to a user" do
      solution = create(:solution)
      expect(solution).to respond_to(:user)
    end

    it "has many feedbacks" do
      solution = create(:solution)
      expect(solution).to respond_to(:feedbacks)
    end
  end

  describe "statuses" do
    it { should define_enum_for(:status).with([:Submitted, :Solved, :Incorrect])}

    it "is created with the status of submitted" do
      solution = create(:solution)
      expect(solution.status).to eq("Submitted")
    end

    it "can be given the status of solved" do
      solution = create(:solution)
      expect(solution.status).to eq("Submitted")
      solution.status = 1
      expect(solution.status).to eq("Solved")
    end
  end
end
