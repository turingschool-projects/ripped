require "rails_helper"

describe "a user visits a show page for another user's solution that they have left feedback on" do
  scenario "and clicks the edit button next to their own feedback" do
    user = create(:user)
    user2 = create(:user)
    exercise = create(:exercise)
    create(:solution, user: user, exercise: exercise)
    solution = create(:solution, user: user2, exercise: exercise)
    feedback = create(:feedback, solution_id: solution.id, user: user, comment: "Comment1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    expect(page).to have_content("Comment1")

    click_link "Edit Feedback"

    expect(current_path).to eq(edit_solution_feedback_path(solution, feedback))
    expect(page).to have_content("Edit your feedback")
    expect(page).to have_xpath('//textarea[@id="feedback-update"]')
    expect(page).to have_button("Update Feedback")
  end

  scenario "and edits their feedback" do
    user = create(:user)
    user2 = create(:user)
    exercise = create(:exercise)
    create(:solution, user: user, exercise: exercise)
    solution = create(:solution, user: user2, exercise: exercise)
    feedback = create(:feedback, solution_id: solution.id, user: user, comment: "Comment1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    expect(page).to have_content("Comment1")

    click_link "Edit Feedback"

    fill_in "feedback-update", with: "Sup dawg"

    click_button "Update Feedback"

    expect(current_path).to eq(exercise_solution_path(exercise, solution))
    expect(page).to have_content("Sup dawg")
    expect(page).to_not have_content("Comment1")
    expect(page).to have_content("Your feedback has been updated.")
  end

  scenario "and tries to edit feedback that does not belong to them" do
    user = create(:user)
    user2 = create(:user)
    exercise = create(:exercise)
    solution = create(:solution, user: user, exercise: exercise)
    feedback = create(:feedback, solution_id: solution.id, user: user2, comment: "Comment1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit edit_solution_feedback_path(solution, feedback)
    expect(page).to have_content("You are not authorized to access this page.")
  end
end
