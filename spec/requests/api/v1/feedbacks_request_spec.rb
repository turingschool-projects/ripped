require 'rails_helper'

describe 'GET /api/v1/solutions/:solution_id/feedbacks/:id' do
  it 'returns a single feedback' do
    solution = create(:solution)
    feedback = create(:feedback, solution: solution)

    get "/api/v1/solutions/#{solution.id}/feedbacks/#{feedback.id}"

    feedback_json = JSON.parse(response.body)

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
