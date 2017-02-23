require "rails_helper"

describe "when a user visits the site" do
  context "and they are not logged in" do
    scenario "they do not see a notification bell" do
      visit '/'

      expect(page).to have_content('Login with Census')
      expect(page).to_not have_css("#notification-logo")
    end
  end

  context "and they are logged in" do
    scenario "they do see a notification bell" do
      user = create(:user, census_id: 14)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/exercises'
      expect(page).to have_css("#notification-logo")
    end

    scenario "they see the word none if there are no notifications" do
      exercise = create(:exercise)
      user_1 = create(:user, census_id: 14)
      solution_1 = Solution.create!(content: "Hello", user_id: user_1.id, exercise_id: exercise.id, status: 0)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/'

      expect(page).to have_content("None")

      visit "/exercises"
      expect(page).to have_content("None")
    end

    scenario "they see the correct notification number as a student", :vcr do
      exercise = create(:exercise)
      user_1 = create(:user, census_id: 14)
      solution_1 = Solution.create!(content: "Hello", user_id: user_1.id, exercise_id: exercise.id, status: 1)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit "/exercises"
      expect(page).to have_content("1")
    end

    scenario "they see the correct notification number as an instructor", :vcr do
      exercise_1 = create(:exercise)
      exercise_2 = create(:exercise)
      user_1 = create(:user, census_id: 16, role: 1)
      user_2 = create(:user, census_id: 21)
      solution_1 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_1.id, status: 0)
      solution_2 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_2.id, status: 0)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit "/exercises"
      expect(page).to have_content("2")
    end

    scenario "they see the correct notification number as a student with nothing graded" do
      exercise = create(:exercise)
      user_1 = create(:user, census_id: 14)
      solution_1 = Solution.create!(content: "Hello", user_id: user_1.id, exercise_id: exercise.id, status: 0)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/'

      expect(page).to have_content("None")
      visit "/exercises"
      expect(page).to have_content("None")
    end

    scenario "they see the correct notification number as an instructor with nothing to grade" do
      exercise_1 = create(:exercise)
      exercise_2 = create(:exercise)
      user_1 = create(:user, census_id: 16, role: 1)
      user_2 = create(:user, census_id: 14)
      solution_1 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_1.id, status: 1)
      solution_2 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_2.id, status: 1)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/'

      expect(page).to have_content("None")
      visit "/exercises"
      expect(page).to have_content("None")
    end

    scenario "they see the correct notification on other pages", :vcr do
      exercise_1 = create(:exercise, name: "Hats")
      exercise_2 = create(:exercise, name: "Umbrellas")
      user_1 = create(:user, census_id: 16, role: 1)
      user_2 = create(:user, census_id: 14)
      solution_1 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_1.id, status: 0)
      solution_2 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_2.id, status: 0)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit exercises_path
      expect(page).to have_content("2")
      dashboard_path
      expect(page).to have_content("2")
    end
  end
end
