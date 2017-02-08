require "rails_helper"

describe "/exercises/:id" do
  it "student sees a form to submit a solution" do
    exercise = create(:exercise)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_path(exercise)

    click_on "Submit your solution"

    expect(current_path).to eq(new_exercise_solution_path(exercise))
    expect(page).to have_content("Paste solution here:")
    expect(page).to have_content("Submit Solution")
  end
  it "instructor sees a form to submit a solution" do
    exercise = create(:exercise)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_path(exercise)

    click_on "Submit your solution"

    expect(current_path).to eq(new_exercise_solution_path(exercise))
    expect(page).to have_content("Paste solution here:")
    expect(page).to have_content("Submit Solution")
  end

  it "instructor can submit a solution" do
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
  end
  it "student can submit a solution" do
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
  end

  it "instructor sees errors message if their solution does not submit" do
    exercise = create(:exercise)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit exercise_path(exercise)

    click_on "Submit your solution"
    click_on "Submit Solution"

    expect(page).to have_content("Your solution did not save.")
  end
  it "student sees errors message if their solution does not submit" do
    exercise = create(:exercise)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit exercise_path(exercise)

    click_on "Submit your solution"
    click_on "Submit Solution"

    expect(page).to have_content("Your solution did not save.")
  end
end
