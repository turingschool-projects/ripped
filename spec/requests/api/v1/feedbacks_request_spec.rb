require 'rails_helper'

describe 'GET /api/v1/solutions/:solution_id/feedbacks/:id' do
  it 'returns a single feedback' do
    solution = create(:solution)
    feedback = create(:feedback, solution: solution)

    get "/api/v1/solutions/#{solution.id}/feedbacks/#{feedback.id}"

    feedback_json = JSON.parse(response.body)

    expect(response).to be_success

    expect(feedback_json).to be_a(Hash)
    expect(feedback_json).to have_key("id")
    expect(feedback_json).to have_key("user_id")
    expect(feedback_json).to have_key("solution_id")
    expect(feedback_json).to have_key("comment")
    expect(feedback_json).to have_key("created_at")
    expect(feedback_json).to have_key("updated_at")
    expect(feedback_json).to have_key("status")
  end
end

describe 'PATCH /api/v1/solutions/:solution_id/feedbacks/:id' do
  it 'updates a feedbacks status' do
    solution = create(:solution)
    feedback = create(:feedback, solution: solution)

    headers = {'CONTENT-TYPE' => 'application/json'}
    patch "/api/v1/solutions/#{solution.id}/feedbacks/#{feedback.id}", headers: headers, params: { feedback: { status: "read" } }.to_json

    expect(response).to be_success
    feedback = JSON.parse(response.body)
    expect(feedback["status"]).to eq("read")
  end
end
