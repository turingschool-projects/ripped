require "rails_helper"

describe "/exercises/:id" do
  it "user sees a form to submit a solution" do
    exercise = create(:exercise)
    visit exercise_path(exercise)

    click_on "Submit your solution"

    expect(current_path).to eq(new_solution_path)
    expect(page).to have_content("Paste solution here:")
    expect(page).to have_content("Submit Solution")
  end
end
