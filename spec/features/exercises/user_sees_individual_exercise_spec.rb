require "rails_helper"

describe "/exercises/:id" do
  it "user can see an individual exercise" do
    exercise = create(:exercise)

    visit exercise_path(exercise)

    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.content)
    expect(page).to have_content(exercise.description)
  end
end
