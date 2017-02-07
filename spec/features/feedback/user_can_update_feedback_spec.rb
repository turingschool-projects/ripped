require "rails_helper"

describe "a user visits a show page for another user's solution that they have left feedback on" do
  scenario "and clicks the edit button next to their own feedback" do
    user = create(:user)
    user2 = create(:user)
    exercise = create(:exercise)
    solution = create(:solution, user: user2, exercise: exercise)
    feedback = create(:feedback, solution_id: solution.id, user: user, comment: "Comment1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    expect(page).to have_content("Comment1")

    click_link "Edit Feedback"

    expect(current_path).to eq(edit_solution_feedback_path(solution, feedback))
    expect(page).to have_content("Edit your feedback")
    expect(page).to have_xpath('//textarea[@id="feedback-update"]')
  end
end
