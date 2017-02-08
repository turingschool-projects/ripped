require "rails_helper"

describe "after a user logs in" do
  it "sees a list of exercises" do
    stub = stub_omniauth
    user = create(:user)
    exercise = create(:exercise)
    visit '/'
    expect(page).to have_content('Login with Census')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/exercises"
    expect(page).to have_content("Exercises")
    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.description)
  end
end
