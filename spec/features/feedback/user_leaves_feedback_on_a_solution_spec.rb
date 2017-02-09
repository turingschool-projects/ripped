require "rails_helper"

describe "a user visits a show page for another user's solution" do
  scenario "and successfully creates feedback on that solution" do
    
    user = create(:user)
    user2 = create(:user)
    exercise = create(:exercise)
    create(:solution, user: user, exercise: exercise)
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
    create(:solution, user: user, exercise: exercise)
    solution = create(:solution, user: user2, exercise: exercise)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    fill_in "feedback-content", with: ""
    click_button 'Create Feedback'

    expect(current_path).to eq(exercise_solution_path(exercise, solution))
    expect(page).to have_content("Feedback")
    expect(page).to have_content("Something went wrong.")
  end

  scenario "and has not already submitted a solution for the exercise" do
    user = create(:user)
    user2 = create(:user)
    exercise = create(:exercise)
    solution = create(:solution, user: user2, exercise: exercise)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    expect(page).to have_content("You are not authorized to access this page.")
  end
end

describe "a staff member visits a show page for a user's solution" do
  scenario "and successfully creates feedback on that solution" do
    user = create(:user, role: "instructor")
    user2 = create(:user)
    exercise = create(:exercise)
    create(:solution, user: user, exercise: exercise)
    solution = create(:solution, user: user2, exercise: exercise)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solution_path(exercise, solution)

    fill_in "feedback-content", with: "My Comment"
    click_button 'Create Feedback'

    expect(current_path).to eq(exercise_solution_path(exercise, solution))
    expect(page).to have_content("Feedback")
    expect(page).to have_content("My Comment")
    expect(page).to have_content("(Instructor)")
    expect(page).to have_content("Your comment has been created!")

  end
end
