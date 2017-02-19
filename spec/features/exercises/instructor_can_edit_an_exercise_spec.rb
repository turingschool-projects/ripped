require "rails_helper"

describe "/exercises/:id/edit" do
  scenario "an instructor can edit an existing exercise" do
    tag = create(:tag)
    exercise = create(:exercise, content: "old content", description: "old description")
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit edit_exercise_path(exercise)

    fill_in "exercise[name]", with: "new exercise name"
    fill_in "exercise[description]", with: "new exercise description"
    fill_in "exercise[content]", with: "new exercise content"
    find('#exercise_tag_names').find(:xpath, 'option[1]').select_option
    click_on "Update Exercise"

    expect(page).to have_content("You have successfully updated this exercise.")
    expect(page).to have_content("new exercise name")
    expect(page).to have_content("new exercise description")
    expect(page).to have_content("new exercise content")
    expect(page).to_not have_content("old name")
    expect(page).to_not have_content("old content")
    expect(page).to_not have_content("old description")
  end

  scenario "an instructor sees error when an exercise does not successfully update" do
    exercise = create(:exercise)
    tag = create(:tag)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit edit_exercise_path(exercise)

    fill_in "exercise[name]", with: "new exercise name"
    fill_in "exercise[description]", with: "new exercise description"
    fill_in "exercise[content]", with: ""
    find('#exercise_tag_names').find(:xpath, 'option[1]').select_option
    click_on "Update Exercise"

    expect(page).to have_content("There was a problem updating your exercise. Please try again.")
  end
end

describe "/exercises" do
  scenario "instructor sees 'update exercise' button" do
    create(:exercise)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    expect(page).to have_link("mode_edit")
  end

  scenario "student does not see 'update exercise' button" do
    create(:exercise)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    expect(page).to_not have_link("mode_edit")
  end
end

describe "/exercises/:id" do
  scenario "instructor sees 'update exercise' button on individual exercise" do
    exercise = create(:exercise)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path(exercise)

    expect(page).to have_link("mode_edit")
  end

  scenario "student does not see 'update exercise' button on individual exercise" do
    exercise = create(:exercise)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path(exercise)

    expect(page).to_not have_link("Edit")
  end
end
