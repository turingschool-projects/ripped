require "rails_helper"

describe "a user visits a show page for another user's solution" do
  scenario "and sees a list of feedback items", :vcr do
    user = create(:user, census_id: 14)
    user2 = create(:user, census_id: 21)
    exercise = create(:exercise)
    create(:solution, user: user, exercise: exercise)
    solution = create(:solution, user: user2, exercise: exercise)
    feedback = create(:feedback, solution_id: solution.id, comment: "Comment1")
    feedback2 = create(:feedback, solution_id: solution.id, comment: "Comment2")
    feedback3 = create(:feedback, solution_id: solution.id, comment: "Comment3")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    expect(page).to have_content("Feedback")
    expect(page).to have_content(feedback.comment)
    expect(page).to have_content(feedback2.comment)
    expect(page).to have_content(feedback3.comment)
  end

  scenario "and sees a form to add feedback", :vcr do
    user = create(:user, census_id: 14)
    user2 = create(:user, census_id: 21)
    exercise = create(:exercise)
    create(:solution, user: user, exercise: exercise)
    solution = create(:solution, user: user2, exercise: exercise)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    expect(page).to have_content("Leave Feedback")
    expect(page).to have_xpath('//textarea[@id="feedback-content"]')
  end
end
