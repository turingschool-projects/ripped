require "rails_helper"

describe "/exercises" do
  it "a user can view exercises" do
    exercise = create(:exercise)

    visit exercises_path

    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.description)
  end

  it "a user can view exercises by track" do
    tag_1 = create(:tag, name: "js")
    tag_2 = create(:tag, name: "ruby")
    exercise_js = create(:exercise)
    exercise_js_1 = create(:exercise)
    exercise_ruby = create(:exercise)
    exercise_js.tags = [tag_1]
    exercise_js_1.tags = [tag_1]
    exercise_ruby.tags = [tag_2]

    visit exercises_path

    expect(page).to have_content(exercise_js.name)
    expect(page).to have_content(exercise_js.description)
  end
end
