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

    it "has many feedbacks" do
      user = create(:user)
      expect(user).to respond_to(:feedbacks)
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

  describe ".census_name(token)" do
    it "returns the user's name from census", :vcr do
      user = create(:user, census_id: 55)
      expect(user.census_name(ENV['census_token'])).to eq("Anna Dolan")
    end
  end

  describe ".census_cohort(token)" do
    it "returns the user's cohort from census", :vcr do
      user = create(:user, census_id: 55)
      expect(user.census_cohort(ENV['census_token'])).to eq("1608-BE")
    end
  end
end
