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

  it "a user can view exercises by track" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    tag_1 = create(:tag, name: "javascript")
    tag_2 = create(:tag, name: "ruby")
    exercise_js = create(:exercise)
    exercise_js_1 = create(:exercise)
    exercise_ruby = create(:exercise)
    exercise_js.tags = [tag_1]
    exercise_js_1.tags = [tag_1]
    exercise_ruby.tags = [tag_2]

    visit exercises_path
    click_button "JavaScript"

    expect(page).to have_content(exercise_js.name)
    expect(page).to have_content(exercise_js.description)

    visit exercises_path
    click_button "Ruby"

    expect(page).to have_content(exercise_ruby.name)
    expect(page).to have_content(exercise_ruby.description)
  end
end
