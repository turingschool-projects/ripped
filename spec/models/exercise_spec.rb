require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe "validations" do
    it "is invalid without a name" do
      exercise = Exercise.create(content: "exercise content")
      expect(exercise).to_not be_valid
    end
    it "is invalid without content" do
      exercise = Exercise.create(name: "exercise name")
      expect(exercise).to_not be_valid
    end
    it "is valid with all attributes" do
      exercise = Exercise.create(name: "exercise name", content: "exercise content")
      expect(exercise).to be_valid
    end
  end
  describe "relationships" do
    it "has many solutions" do
      exercise = create(:exercise)
      expect(exercise).to respond_to(:solutions)
    end
  end
end
