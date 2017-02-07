require "rails_helper"

describe "/exercises/new" do
  scenario "an instructor can create an exercise" do
    visit new_exercise_path

    fill_in "exercise[name]", with: "exercise name"
    fill_in "exercise[description]", with: "exercise description"
    fill_in "exercise[content]", with: "exercise content"
    click_on "Create Exercise"

    exercise = Exercise.last

    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.description)
    expect(page).to have_content(exercise.content)
    expect(page).to have_content("You have successfully created an exercise")
  end
  scenario "an instructor sees error when an exercise does not successfully create" do
    visit new_exercise_path

    fill_in "exercise[name]", with: "exercise name"
    fill_in "exercise[description]", with: "exercise description"
    click_on "Create Exercise"

    expect(page).to have_content("There was a problem creating your exercise. Please try again.")
  end
end

describe "/exercises" do
  scenario "instructor sees 'create new exercise' button" do
    visit exercises_path

    expect(page).to have_link("Create New Exercise")
  end
  xscenario "student does not see 'create new exercise' button" do
    visit exercises_path

    expect(page).to_not have_link("Create New Exercise")
  end
end
