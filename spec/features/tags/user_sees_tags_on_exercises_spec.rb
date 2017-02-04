require "rails_helper"

describe "/exercises" do
  it "user sees difficulty tag on exercises" do
    exercise = create(:exercise)
    tag = Tag.create(name: "easy")
    exercise.tags =[tag]

    visit exercises_path

    expect(page).to have_content("easy")
  end
end
