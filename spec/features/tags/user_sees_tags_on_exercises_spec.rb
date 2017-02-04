require "rails_helper"

describe "/exercises" do
  it "user sees difficulty tag on exercises" do
    exercise = create(:exercise)
    tag = Tag.create(name: "easy")
    exercise.tags =[tag]

    visit exercises_path

    expect(page).to have_content(tag.name)
  end
  it "user sees language tag on exercises" do
    exercise = create(:exercise)
    tag = Tag.create(name: "ruby")
    exercise.tags =[tag]

    visit exercises_path

    expect(page).to have_content(tag.name)
  end
  it "user sees multiple tags on exercises" do
    exercise = create(:exercise)
    tag_1 = Tag.create(name: "ruby")
    tag_2 = Tag.create(name: "easy")
    tag_3 = Tag.create(name: "hard")
    exercise.tags =[tag_1, tag_2]

    visit exercises_path

    expect(page).to have_content(tag_1.name)
    expect(page).to have_content(tag_2.name)
    expect(page).to_not have_content(tag_3.name)
  end
end
describe "/exercises/:id" do
  it "user sees difficulty tag on specific exercise" do
    exercise = create(:exercise)
    tag = Tag.create(name: "easy")
    exercise.tags =[tag]

    visit exercise_path(exercise)

    expect(page).to have_content(tag.name)
  end
  it "user sees language tag on specific exercise" do
    exercise = create(:exercise)
    tag = Tag.create(name: "ruby")
    exercise.tags =[tag]

    visit exercise_path(exercise)

    expect(page).to have_content(tag.name)
  end
  it "user sees multiple tags on specific exercise" do
    exercise = create(:exercise)
    tag_1 = Tag.create(name: "ruby")
    tag_2 = Tag.create(name: "easy")
    tag_3 = Tag.create(name: "hard")
    exercise.tags =[tag_1, tag_2]

    visit exercise_path(exercise)

    expect(page).to have_content(tag_1.name)
    expect(page).to have_content(tag_2.name)
    expect(page).to_not have_content(tag_3.name)
  end
end
