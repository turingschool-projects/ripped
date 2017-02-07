require "rails_helper"

describe "a user adds feedback to a solution" do
  scenario "and sees a form to add feedback" do
    user = create(:user)
    user2 = create(:user)
    exercise = create(:exercise)
    solution = create(:solution, user: user2, exercise: exercise)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    expect(page).to have_content("Leave Feedback")
    expect(page).to have_xpath('//textarea[@id="feedback-content"]')
  end
end
