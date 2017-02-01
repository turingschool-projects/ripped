require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is invalid without a census_id" do
      user = User.create()
      expect(user).to_not be_valid
    end
    it "is valid with all attributes" do
      user = User.create(census_id: 1)
      expect(user).to be_valid
    end
  end
end
