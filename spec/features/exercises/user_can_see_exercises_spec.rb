require "rails_helper"

describe "/exercises" do
  it "instructor can view exercises" do
    exercise = create(:exercise)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.description)
  end
  it "student can view exercises" do
    exercise = create(:exercise)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.description)
  end
end
