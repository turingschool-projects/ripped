require "rails_helper"

describe "/exercises/:id" do
  scenario "instructor can unpublish exercise from show" do
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    exercise = create(:exercise)

    visit exercise_path(exercise)

    click_on "unpublish"

    expect(page).to have_content("#{exercise.name} has been unpublished")
    expect(current_path).to eq(exercises_path)
    expect(page).to_not have_content(exercise.description)
  end
  scenario "instructor can publish exercise from show" do
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    exercise = create(:exercise, status: 1)

    visit exercise_path(exercise)

    click_on "publish"

    expect(page).to have_content("#{exercise.name} has been published")
    expect(current_path).to eq(exercise_path(exercise))
    expect(page).to have_content(exercise.description)
  end
  scenario "cannot unpublish an exercise from show" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    exercise = create(:exercise)

    visit exercise_path(exercise)

    expect(page).to_not have_link("unpublish")
  end
end

describe "/exercises" do
  scenario "instructor can unpublish exercise from index" do
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    exercise = create(:exercise)

    visit exercises_path

    click_on "unpublish"

    expect(page).to have_content("#{exercise.name} has been unpublished")
    expect(current_path).to eq(exercises_path)
    expect(page).to_not have_content(exercise.description)
  end
  scenario "cannot unpublish an exercise from index" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    exercise = create(:exercise)

    visit exercises_path

    expect(page).to_not have_link("unpublish")
  end
end
