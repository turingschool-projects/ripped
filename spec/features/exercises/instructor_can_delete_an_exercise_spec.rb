require "rails"


describe "/exercises" do
  xscenario "an instructor can delete an exercise" do
    exercise = create(:exercise)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    click_on "delete"

    expect(page).to have_content("#{exercise.name} has been deleted.")
    expect(page).to_not have_content(exercise.description)
  end
  xscenario "a student cannot delete an exercise" do

  end
end