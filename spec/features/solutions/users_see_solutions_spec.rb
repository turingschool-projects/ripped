require "rails_helper"

describe "/exercises/:id/solutions" do
  scenario "instructor sees all solutions for an exercise" do
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    exercise = create(:exercise)
    solution = create(:solution)
    exercise.solutions = [solution]

    visit exercise_solutions_path(exercise)

    expect(page).to have_content(solution.content)
  end
end
