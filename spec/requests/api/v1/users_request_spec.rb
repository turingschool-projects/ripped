require 'rails_helper'

describe 'GET /api/v1/users/:id' do
  it 'returns a single user' do
    user = create(:user)

    get "/api/v1/users/#{user.id}"

    user_json = JSON.parse(response.body)

    expect(response).to be_success
    expect(user_json).to be_a(Hash)
  end
end
