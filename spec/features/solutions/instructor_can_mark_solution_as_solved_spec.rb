require "rails_helper"

describe "an instructor can mark a solution as solved" do
  scenario "and sees a status for that solution", :vcr do
    exercise = create(:exercise)
    user = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

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

    click_on "Mark as Solved"
    expect(page).to have_content("Status: Solved")

  end
end
