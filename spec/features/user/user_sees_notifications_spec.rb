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
      user = create(:user)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/exercises'
      expect(page).to have_css("#notification-logo")
    end

    scenario "students see no unread feedback if there are no notifications" do
      exercise = create(:exercise)
      user_1 = create(:user)
      solution_1 = Solution.create!(content: "Hello", user_id: user_1.id, exercise_id: exercise.id, status: 0)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/'

      expect(page).to have_content("No Unread Feedback")

      visit "/exercises"
      expect(page).to have_content("No Unread Feedback")
    end

    scenario "they see the correct notification number as a student", :vcr do
      exercise = create(:exercise)
      user_1 = create(:user)
      solution_1 = Solution.create!(content: "Hello", user_id: user_1.id, exercise_id: exercise.id, status: 1)
      feedback_1 = create(:feedback, solution_id: solution_1.id, comment: "Comment1")

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit "/exercises"
      expect(page).to have_content("1 Unread Feedback")
    end

    scenario "they see the correct notification number as an instructor", :vcr do
      exercise_1 = create(:exercise)
      exercise_2 = create(:exercise)
      user_1 = create(:user, role: "instructor")
      user_2 = create(:user)
      solution_1 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_1.id, status: 0)
      solution_2 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_2.id, status: 0)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit "/exercises"
      expect(page).to have_content("2 Solutions Need Feedback")
    end

    scenario "they see the correct notification number as a student with no feedback" do
      exercise = create(:exercise)
      user_1 = create(:user)
      solution_1 = Solution.create!(content: "Hello", user_id: user_1.id, exercise_id: exercise.id, status: 0)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/'
      
      expect(page).to have_content("No Unread Feedback")
      visit "/exercises"
      expect(page).to have_content("No Unread Feedback")    
    end

    scenario "they see the correct notification number as an instructor with nothing to comment on" do
      exercise_1 = create(:exercise)
      exercise_2 = create(:exercise)
      user_1 = create(:user, role: 1)
      user_2 = create(:user)
      solution_1 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_1.id, status: 1)
      solution_2 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_2.id, status: 1)
      feedback_1 = create(:feedback, solution_id: solution_1.id, comment: "Comment1")
      feedback_2 = create(:feedback, solution_id: solution_2.id, comment: "Comment2")

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/'

      expect(page).to have_content("No Solutions Need Feedback")
      visit "/exercises"
      expect(page).to have_content("No Solutions Need Feedback")
    end

    scenario "they see the correct notification on other pages", :vcr do
      exercise_1 = create(:exercise, name: "Hats")
      exercise_2 = create(:exercise, name: "Umbrellas")
      user_1 = create(:user, role: 1)
      user_2 = create(:user)
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
