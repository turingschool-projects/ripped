require 'rails_helper'
# As an authenticated instructor
# When I view my dashboard
# I can see a list of submitted exercises
# and the student's name, the language of the exercise, the difficulty, and the name

describe "a user accesses the dashboard" do
  context "a user is logged in as a student" do
    scenario "and cannot see the instructor dashboard", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to_not have_content("Instructor Dashboard")
    end
  end

  context "a user is logged in as an instructor" do
    scenario "and can see the instructor dashboard", :vcr do
      user = create(:user, role: "instructor")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content("Instructor Dashboard")
    end
  end
end