require "rails_helper"

describe "/exercises/:id" do
  it "user sees a form to submit a solution" do
    exercise = create(:exercise)
    visit exercise_path(exercise)

    click_on "Submit your solution"

    expect(current_path).to eq(new_exercise_solution_path(exercise))
    expect(page).to have_content("Paste solution here:")
    expect(page).to have_content("Submit Solution")
  end

  it "user can submit a solution" do
    exercise = create(:exercise)
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
  it "user sees errors message if their solution does not submit" do
    exercise = create(:exercise)
    visit exercise_path(exercise)

    click_on "Submit your solution"
    click_on "Submit Solution"

    expect(page).to have_content("Your solution did not save.")
  end
end
