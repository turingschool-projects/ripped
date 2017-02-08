require "rails_helper"

describe "a user submits a solution" do
  scenario "and sees a status for that solution" do
    exercise = create(:exercise)
    user = create(:user)

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
  end

  scenario "and it is specific for their account" do
    exercise = create(:exercise)
    user_1 = create(:user)
    user_2 = create(:user)

    solution_1 = Solution.create!(content: "Hello", user_id: user_1.id, exercise_id: exercise.id, status: 0)
    solution_2 = Solution.create!(content: "Hello", user_id: user_2.id, exercise_id: exercise.id, status: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit exercise_solution_path(id: solution_1.id, exercise_id: exercise.id)

    expect(page).to have_content("Your solution for #{exercise.name}")
    expect(page).to have_content("Status: Submitted")
    expect(page).to_not have_content("Status: Solved")
    expect(page).to have_content(solution_1.content)
    expect(Solution.second.status).to eq("Solved")
  end
end
