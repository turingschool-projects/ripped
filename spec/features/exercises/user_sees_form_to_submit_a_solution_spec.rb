require "rails_helper"

describe "/exercises/:id" do
  it "user sees a form to submit a solution" do
    exercise = create(:exercise)
    visit exercise_path(exercise)

    click_on "Submit your solution"

    expect(current_path).to eq(exercise_path(exercise))
    expect(page).to have_content("Paste solution here")
  end
end
