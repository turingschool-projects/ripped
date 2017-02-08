require "rails_helper"

describe "/exercises/:id" do
  it "instructor can see an individual exercise" do
    exercise = create(:exercise)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_path(exercise)

    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.content)
    expect(page).to have_content(exercise.description)
  end
  it "student can see an individual exercise" do
    exercise = create(:exercise)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_path(exercise)

    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.content)
    expect(page).to have_content(exercise.description)
  end
end
