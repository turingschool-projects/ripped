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

  it "sees a list of exercises by track all" do
    stub = stub_omniauth
    user = create(:user)
    tag_1 = create(:tag, name: "javascript")
    tag_2 = create(:tag, name: "ruby")
    exercise_js = create(:exercise)
    exercise_js_1 = create(:exercise)
    exercise_ruby = create(:exercise)
    exercise_js.tags = [tag_1]
    exercise_js_1.tags = [tag_1]
    exercise_ruby.tags = [tag_2]

    visit '/'
    expect(page).to have_content('Login with Census')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/exercises"
    expect(page).to have_content("Exercises")
    expect(page).to have_content(exercise_js.name)
    expect(page).to have_content(exercise_ruby.description)
  end
end
