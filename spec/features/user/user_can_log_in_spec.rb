require 'rails_helper'

describe 'a user can log in' do
  scenario 'when a user vists root it can log in' do
    stub = stub_omniauth
    user = User.create!(census_id: stub.uid)

    visit '/'
    expect(page).to have_content('Login with Census')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    click_link "Login with Census"
    expect(page).to have_content("Exercises")
  end
  scenario 'when a user vists root it can log out' do
    stub = stub_omniauth
    user = User.create!(census_id: stub.uid)

    visit '/'
    expect(page).to have_content('Login with Census')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    click_link "Login with Census"
    expect(page).to have_content("Exercises")

    visit '/'
    expect(page).to have_content('Log Out')
  end
end
