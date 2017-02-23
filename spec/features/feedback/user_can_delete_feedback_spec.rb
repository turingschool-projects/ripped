require "rails_helper"

describe "a user visits a show page for a solution that they have left feedback on" do
  scenario "and clicks the delete button next to their own feedback", :vcr do
    user = create(:user, census_id: 14)
    user2 = create(:user, census_id:22)
    exercise = create(:exercise)
    create(:solution, user: user, exercise: exercise)
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

  scenario "and does not see a delete button next to feedback from other users", :vcr do
    user = create(:user, census_id: 14)
    user2 = create(:user, census_id: 21)
    user3 = create(:user, census_id: 22)
    exercise = create(:exercise)
    create(:solution, user: user3, exercise: exercise)
    solution = create(:solution, user: user2, exercise: exercise)
    feedback = create(:feedback, solution_id: solution.id, user: user, comment: "Comment1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user3)

    visit exercise_solution_path(exercise, solution)

    expect(page).to have_content("Comment1")

    expect(page).to_not have_content("Delete")
  end

  scenario "an instructor can delete anyone's feedback", :vcr do
    user = create(:user, census_id: 14)
    user2 = create(:user, census_id: 21)
    user3 = create(:user, census_id: 16, role: 1)
    exercise = create(:exercise)
    create(:solution, user: user3, exercise: exercise)
    solution = create(:solution, user: user2, exercise: exercise)
    feedback = create(:feedback, solution_id: solution.id, user: user, comment: "Comment1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user3)

    visit exercise_solution_path(exercise, solution)

    expect(page).to have_content("Comment1")

    expect(page).to have_content("Delete")
  end
end
