require "rails_helper"

describe "/dashboard" do
  it "a user can see a heading for feedback" do
    user = User.create(census_id: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit dashboard_path

    expect(page).to have_content("Feedback")
  end
end
