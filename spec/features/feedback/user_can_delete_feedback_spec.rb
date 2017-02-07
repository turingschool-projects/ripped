require "rails_helper"

describe "a user visits a show page for another user's solution that they have left feedback on" do
  scenario "and clicks the delete button next to their own feedback" do
    user = create(:user)
    user2 = create(:user)
    exercise = create(:exercise)
    solution = create(:solution, user: user2, exercise: exercise)
    feedback = create(:feedback, solution_id: solution.id, user: user, comment: "Comment1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    expect(page).to have_content("Comment1")

    click_link "Delete"

    expect(current_path).to eq(exercise_solution_path(exercise, solution))
    expect(page).to_not have_content("Comment1")
    expect(page).to have_content("Your feedback has been deleted.")
  end

  scenario "and does not see a delete button next to feedback from other users" do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    exercise = create(:exercise)
    solution = create(:solution, user: user2, exercise: exercise)
    feedback = create(:feedback, solution_id: solution.id, user: user, comment: "Comment1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user3)

    visit exercise_solution_path(exercise, solution)

    expect(page).to have_content("Comment1")

    expect(page).to_not have_content("Delete")
  end
end
