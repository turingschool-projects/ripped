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
      stub = stub_omniauth
      user = User.create!(census_id: stub.uid)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      click_link "Login with Census"
      expect(page).to have_css("#notification-logo")
    end
    
    scenario "they see a number next to the notification alert" do
      stub = stub_omniauth
      exercise = create(:exercise)
      user_1 = User.create!(census_id: stub.uid)
      solution_1 = Solution.create!(content: "Hello", user_id: user_1.id, exercise_id: exercise.id, status: 0)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      click_link "Login with Census"
      expect(page).to have_content("0")
    end
    
    scenario "they see the correct notification number as a student" do
      stub = stub_omniauth
      exercise = create(:exercise)
      user_1 = User.create!(census_id: stub.uid)
      solution_1 = Solution.create!(content: "Hello", user_id: user_1.id, exercise_id: exercise.id, status: 1)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      click_link "Login with Census"
      expect(page).to have_content("1")
    end

    scenario "they see the correct notification number as an instructor" do
      stub_1 = stub_omniauth
      stub_2 = stub_omniauth
      exercise_1 = create(:exercise)
      exercise_2 = create(:exercise)
      user_1 = User.create!(census_id: stub_1.uid, role: 1)
      user_2 = User.create!(census_id: stub_2.uid, role: 0)
      solution_1 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_1.id, status: 0)
      solution_2 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_2.id, status: 0)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      click_link "Login with Census"
      expect(page).to have_content("2")
    end
    
    scenario "they see the correct notification number as a student with nothing gradded" do
      stub = stub_omniauth
      exercise = create(:exercise)
      user_1 = User.create!(census_id: stub.uid)
      solution_1 = Solution.create!(content: "Hello", user_id: user_1.id, exercise_id: exercise.id, status: 0)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      click_link "Login with Census"
      expect(page).to have_content("0")
    end

    scenario "they see the correct notification number as an instructor with nothing to grade" do
      stub_1 = stub_omniauth
      stub_2 = stub_omniauth
      exercise_1 = create(:exercise)
      exercise_2 = create(:exercise)
      user_1 = User.create!(census_id: stub_1.uid, role: 1)
      user_2 = User.create!(census_id: stub_2.uid, role: 0)
      solution_1 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_1.id, status: 1)
      solution_2 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise_2.id, status: 1)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      click_link "Login with Census"
      expect(page).to have_content("0")
    end
  end
end