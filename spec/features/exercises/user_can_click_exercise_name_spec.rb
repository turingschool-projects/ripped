require "rails_helper"

describe "/exercises/:id" do
  it "instructor can click on the exercise to be taken to the show view" do
    exercise_1, exercise_2 = create_list(:exercise, 2)
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path
    click_link exercise_1.name

    expect(current_path).to eq(exercise_path(exercise_1))
    expect(page).to have_content(exercise_1.name)
    expect(page).to have_content(exercise_1.content)
    expect(page).to have_content(exercise_1.description)
    expect(page).to_not have_content(exercise_2.name)
    expect(page).to_not have_content(exercise_2.content)
    expect(page).to_not have_content(exercise_2.description)
  end
  it "student can click on the exercise to be taken to the show view" do
    exercise_1, exercise_2 = create_list(:exercise, 2)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path
    click_link exercise_1.name

    expect(current_path).to eq(exercise_path(exercise_1))
    expect(page).to have_content(exercise_1.name)
    expect(page).to have_content(exercise_1.content)
    expect(page).to have_content(exercise_1.description)
    expect(page).to_not have_content(exercise_2.name)
    expect(page).to_not have_content(exercise_2.content)
    expect(page).to_not have_content(exercise_2.description)
  end
end
