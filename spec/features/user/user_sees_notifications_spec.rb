require "rails_helper"

describe "when a user visits the site" do
  context "and they are not logged in" do
    scenario "they do not see a notification bell" do
      visit '/'
      
      expect(page).to have_content('Login with Census')
      expect(page).to_not have_css("#notification-logo")
    end
  end
  
  context "and they are logged in" do
    scenario "they do see a notification bell" do
      stub = stub_omniauth
      user = User.create!(census_id: stub.uid)

      visit '/'
      expect(page).to have_content('Login with Census')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      click_link "Login with Census"
      expect(page).to have_css("#notification-logo")
    end
  end
end