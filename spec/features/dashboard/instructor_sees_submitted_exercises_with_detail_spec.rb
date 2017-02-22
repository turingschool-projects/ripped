require 'rails_helper'

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

    scenario "and can see a list of submitted solutions", :vcr do
      user1 = create(:user, role: "instructor")
      user2 = create(:user)
      user3 = create(:user)
      tag_1 = create(:tag, name: "ruby")
      tag_2 = create(:tag, name: "easy")
      exercise1 = create(:exercise)
      exercise1.tags =[tag_1, tag_2]
      exercise2 = create(:exercise)
      exercise2.tags =[tag_1, tag_2]
      solution1 = create(:solution, exercise_id: exercise2.id, user_id: user2.id, status: "Submitted")
      solution2 = create(:solution, exercise_id: exercise1.id, user_id: user3.id, status: "Submitted")


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit dashboard_path

      expect(page).to have_content("Instructor Dashboard")
      expect(page).to have_content("Submitted Exercises")
      within(:css, "#all-submitted") do
        expect(page).to have_link(solution1.exercise.name, href: exercise_solution_path(exercise2, solution1))
        expect(page).to have_link(solution2.exercise.name, href: exercise_solution_path(exercise1, solution2))
      end

    end

    scenario "and can see the students name and exercise details", :vcr do
      user1 = create(:user, role: "instructor")
      user2 = create(:user)
      tag_1 = create(:tag, name: "ruby")
      tag_2 = create(:tag, name: "easy")
      exercise1 = create(:exercise)
      exercise1.tags =[tag_1, tag_2]
      solution1 = create(:solution, exercise_id: exercise1.id, user_id: user2.id, status: "Submitted")


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit dashboard_path

      expect(page).to have_content("Instructor Dashboard")
      expect(page).to have_content("Submitted Exercises")
      within(:css, "#all-submitted") do
        expect(page).to have_content(user2.first_name)
        expect(page).to have_content(user2.last_name)
        expect(page).to have_content(tag_1.name)
        expect(page).to have_content(tag_2.name)
        expect(page).to have_content(solution1.exercise.name)
      end
    end
  end
end





