require "rails_helper"

describe "/exercises" do
  it "instructor sees difficulty tag on exercises" do
    exercise = create(:exercise)
    tag = Tag.create(name: "easy")
    exercise.tags =[tag]
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    expect(page).to have_content(tag.name)
  end

  it "student sees difficulty tag on exercises" do
    exercise = create(:exercise)
    tag = Tag.create(name: "easy")
    exercise.tags =[tag]
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    expect(page).to have_content(tag.name)
  end

  it "instructor sees language tag on exercises" do
    exercise = create(:exercise)
    tag = Tag.create(name: "ruby")
    exercise.tags =[tag]
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    expect(page).to have_content(tag.name)
  end

  it "student sees language tag on exercises" do
    exercise = create(:exercise)
    tag = Tag.create(name: "ruby")
    exercise.tags =[tag]
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    expect(page).to have_content(tag.name)
  end

  it "instructor sees multiple tags on exercises" do
    exercise = create(:exercise)
    tag_1 = Tag.create(name: "ruby")
    tag_2 = Tag.create(name: "easy")
    tag_3 = Tag.create(name: "hard")
    exercise.tags =[tag_1, tag_2]
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    within('#all-exercises') do
      expect(page).to have_content(tag_1.name)
      expect(page).to have_content(tag_2.name)
      expect(page).to_not have_content(tag_3.name)
    end

  end

  it "student sees multiple tags on exercises" do
    exercise = create(:exercise)
    tag_1 = Tag.create(name: "ruby")
    tag_2 = Tag.create(name: "easy")
    tag_3 = Tag.create(name: "hard")
    exercise.tags =[tag_1, tag_2]
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercises_path

    within('#all-exercises') do
      expect(page).to have_content(tag_1.name)
      expect(page).to have_content(tag_2.name)
      expect(page).to_not have_content(tag_3.name)
    end
  end

end
describe "/exercises/:id" do
  it "instructor sees difficulty tag on specific exercise" do
    exercise = create(:exercise)
    tag = Tag.create(name: "easy")
    exercise.tags =[tag]
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_path(exercise)

    expect(page).to have_content(tag.name)
  end

  it "student sees difficulty tag on specific exercise" do
    exercise = create(:exercise)
    tag = Tag.create(name: "easy")
    exercise.tags =[tag]
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_path(exercise)

    expect(page).to have_content(tag.name)
  end

  it "instructor sees language tag on specific exercise" do
    exercise = create(:exercise)
    tag = Tag.create(name: "ruby")
    exercise.tags =[tag]
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_path(exercise)

    expect(page).to have_content(tag.name)
  end

  it "student sees language tag on specific exercise" do
    exercise = create(:exercise)
    tag = Tag.create(name: "ruby")
    exercise.tags =[tag]
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_path(exercise)

    expect(page).to have_content(tag.name)
  end

  it "instructor sees multiple tags on specific exercise" do
    exercise = create(:exercise)
    tag_1 = Tag.create(name: "ruby")
    tag_2 = Tag.create(name: "easy")
    tag_3 = Tag.create(name: "hard")
    exercise.tags =[tag_1, tag_2]
    user = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_path(exercise)

    expect(page).to have_content(tag_1.name)
    expect(page).to have_content(tag_2.name)
    expect(page).to_not have_content(tag_3.name)
  end

  it "student sees multiple tags on specific exercise" do
    exercise = create(:exercise)
    tag_1 = Tag.create(name: "ruby")
    tag_2 = Tag.create(name: "easy")
    tag_3 = Tag.create(name: "hard")
    exercise.tags =[tag_1, tag_2]
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_path(exercise)

    expect(page).to have_content(tag_1.name)
    expect(page).to have_content(tag_2.name)
    expect(page).to_not have_content(tag_3.name)
  end
end
