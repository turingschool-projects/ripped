# As a user,
# When I view a solution
# Then I see a label indicated if the solution is submitted or solved
# And it is specific to my user account

require "rails_helper"

describe "a user submits a solution" do
  scenario "and sees a status for that solution" do
    exercise = create(:exercise)
    stub = stub_omniauth
    user = User.create!(census_id: stub.uid)

    visit '/'
    expect(page).to have_content('Login with Census')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    click_link "Login with Census"
    
    visit exercise_path(exercise)

    user_solution = "my solution"

    click_on "Submit your solution"
    fill_in "solution[content]", with: user_solution
    click_on "Submit Solution"

    solution = Solution.last

    expect(current_path).to eq(exercise_solution_path(exercise, solution))
    expect(page).to have_content("You have successfully submitted your solution.")
    expect(page).to have_content("Your solution for #{exercise.name}")
    expect(page).to have_content("Status: Submitted")
    expect(page).to have_content(user_solution)
  end

  scenario "and it is specific for their account" do
    exercise = create(:exercise)
    stub_1 = stub_omniauth
    stub_2 = stub_omniauth
    user_1 = User.create!(census_id: stub_1.uid)
    user_2 = User.create!(census_id: stub_2.uid)
    solution_2 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise.id, status: 1)
    visit '/'
    expect(page).to have_content('Login with Census')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    click_link "Login with Census"
    
    visit exercise_path(exercise)

    user_1_solution = "my solution"

    click_on "Submit your solution"
    fill_in "solution[content]", with: user_1_solution
    click_on "Submit Solution"

    solution = Solution.where(user_id: user_1.id)

    expect(page).to have_content("You have successfully submitted your solution.")
    expect(page).to have_content("Your solution for #{exercise.name}")
    expect(page).to have_content("Status: Submitted")
    expect(page).to_not have_content("Status: Solved")
    expect(page).to have_content(user_1_solution)
  end
end