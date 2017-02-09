require "rails"


describe "/exercises" do
  scenario "an instructor can delete an exercise" do
    exercise = create(:exercise)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    click_on "delete"

    expect(page).to have_content("#{exercise.name} has been unpublished.")
    expect(page).to_not have_content(exercise.description)
  end
  scenario "a student cannot delete an exercise" do
    exercise = create(:exercise)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    expect(page).to_not have_link("delete")
  end
end
