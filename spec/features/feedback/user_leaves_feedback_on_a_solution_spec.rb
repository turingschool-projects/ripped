require "rails_helper"

describe "a user isits a show page for another user's solution" do
  scenario "and creates feedback on that solution" do
    user = create(:user)
    user2 = create(:user)
    exercise = create(:exercise)
    solution = create(:solution, user: user2, exercise: exercise)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    fill_in "feedback-content", with: "My Comment"
    click_button 'Create Feedback'

    expect(current_path).to eq(exercise_solution_path(exercise, solution))
    expect(page).to have_content("Feedback")
    expect(page).to have_content("My Comment")
    expect(page).to have_content("Your comment has been created!")

  end

  scenario "and does not add any content in the comment form" do
    user = create(:user)
    user2 = create(:user)
    exercise = create(:exercise)
    solution = create(:solution, user: user2, exercise: exercise)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    fill_in "feedback-content", with: ""
    click_button 'Create Feedback'

    expect(current_path).to eq(exercise_solution_path(exercise, solution))
    expect(page).to have_content("Feedback")
    expect(page).to have_content("Something went wrong.")
  end
end
