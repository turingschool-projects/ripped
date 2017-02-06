require 'rails_helper'

describe "/users/:id" do
  it "a user can see a list of exercises in progress on their dashboard" do
    user = User.create(census_id: 1)
    exercise1 = create(:exercise)
    exercise2 = create(:exercise)
    solution1 = create(:solution, exercise_id: exercise2.id, user_id: user.id, status: "Submitted")
    solution2 = create(:solution, exercise_id: exercise1.id, user_id: user.id, status: "Solved")
    visit user_path(user)

    expect(page).to have_content("Exercises in Progress")

    within(:css, "#in-progress") do
      expect(page).to have_link(solution1.exercise.name, href: exercise_solution_path(exercise2, solution1))
      expect(page).to_not have_content(solution2.exercise.name)
    end
  end

  it "a user can see finished exercises" do
    user = User.create(census_id: 1)
    exercise1 = create(:exercise)
    exercise2 = create(:exercise)
    solution1 = create(:solution, exercise_id: exercise2.id, user_id: user.id, status: "Submitted")
    solution2 = create(:solution, exercise_id: exercise1.id, user_id: user.id, status: "Solved")
    visit user_path(user)

    expect(page).to have_content("Completed Exercises")
    within(:css, "#completed") do
      expect(page).to have_link(solution2.exercise.name, href: exercise_solution_path(exercise1, solution2))
      expect(page).to_not have_content(solution1.exercise.name)
    end
  end
end
