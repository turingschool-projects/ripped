require "rails_helper"

RSpec.describe Solution, type: :model do
  describe "validations" do
    it "is invalid without a name" do
      tag = Tag.create()
      expect(tag).to be_invalid
    end
  end
  describe "relationships" do
    it "has many exercises" do
      tag = create(:tag)
      expect(tag).to respond_to(:exercises)
    end
    it "has many exercise_tags" do
      tag = create(:tag)
      expect(tag).to respond_to(:exercise_tags)
    end
  end
end
