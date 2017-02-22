require "rails_helper"

describe "/exercises/new" do
  scenario "an instructor can create an exercise" do
    create(:tag)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit new_exercise_path
    fill_in "exercise[name]", with: "exercise name"
    fill_in "exercise[description]", with: "exercise description"
    fill_in "exercise[content]", with: "exercise content"
    find('#exercise_tag_names').find(:xpath, 'option[1]').select_option

    click_on "Create Exercise"

    exercise = Exercise.last

    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.description)
    expect(page).to have_content(exercise.content)
    expect(page).to have_content("You have successfully created an exercise")
  end
  scenario "an instructor sees error when an exercise does not successfully create" do
    create(:tag)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_exercise_path

    fill_in "exercise[name]", with: "exercise name"
    fill_in "exercise[description]", with: "exercise description"
    find('#exercise_tag_names').find(:xpath, 'option[1]').select_option
    click_on "Create Exercise"

    expect(page).to have_content("There was a problem creating your exercise. Please try again.")
  end
end

describe "/exercises" do
  scenario "instructor sees 'create new exercise' button" do
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    expect(page).to have_link("Create New Exercise")
  end
  scenario "student does not see 'create new exercise' button" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    expect(page).to_not have_link("Create New Exercise")
  end
end
