require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe "statuses" do
    it { should define_enum_for(:status).with([:unstarted, :started, :attempted])}
    it "is created with status unstarted" do
      exercise = Exercise.create(name: "exercise name", content: "exercise content", description: "exercise description")
      expect(exercise.status).to eq("unstarted")
    end
  end
end