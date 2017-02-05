require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe "statuses" do
    it { should define_enum_for(:status).with([:unstarted, :started, :attempted])}
    it "is created with status unstarted" do
      exercise = Exercise.create(name: "exercise name", content: "exercise content", description: "exercise description")
      expect(exercise.status).to eq("unstarted")
    end
    it "can have status started" do
      exercise = Exercise.create(name: "exercise name", content: "exercise content", description: "exercise description")
      exercise.status = 1
      expect(exercise.status).to eq("started")
    end
    it "can have status attempted" do
      exercise = Exercise.create(name: "exercise name", content: "exercise content", description: "exercise description")
      exercise.status = 2
      expect(exercise.status).to eq("attempted")
    end
  end
end