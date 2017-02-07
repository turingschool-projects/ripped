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
  describe "relationships" do
    it "has many solutions" do
      user = create(:user)
      expect(user).to respond_to(:solutions)
    end
  end
  describe "roles" do
    it { should define_enum_for(:role).with([:student, :instructor])}
    it "is created with the role of student" do
      user = create(:user)
      expect(user.role).to eq("student")
    end
    it "can have the role of instructor" do
      user = create(:user)
      expect(user.role).to eq("student")
      user.role = 1
      expect(user.role).to eq("instructor")
    end
  end
end
