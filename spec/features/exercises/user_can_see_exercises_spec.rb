require "rails_helper"

describe "/exercises" do
  it "a user can view exercises" do
    exercise = Exercise.create(name: "exercise name", content: "exercise content")

    visit exercises_path

    expect(page).to have_content("exercise name")
    expect(page).to have_content("exercise content")
  end
end
