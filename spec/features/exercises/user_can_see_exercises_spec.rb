require "rails_helper"

describe "/exercises" do
  it "a user can view exercises" do
    exercise = create(:exercise)

    visit exercises_path

    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.description)
  end
end
