require "rails_helper"

describe "/users/:id" do
  it "a user can see a heading for feedback" do
    user = User.create(census_id: 1)
    visit user_path(user)

    expect(page).to have_content("Feedback")
  end
end
