require 'rails_helper'

describe 'GET /api/v1/users/:id' do
  it 'returns a single user' do
    user = create(:user)

    get "/api/v1/users/#{user.id}"

    user_json = JSON.parse(response.body)

    expect(response).to be_success
    expect(user_json).to be_a(Hash)
    expect(user_json).to have_key("id")
    expect(user_json).to have_key("census_id")

    expect(user_json).to_not have_key("created_at")
    expect(user_json).to_not have_key("updated_at")
  end

  it "returns a 400 response when user does not exist" do
    get "/api/v1/users/1"

    expect(response.status).to eq(400)
    expect(response.body).to eq("")
  end
end
