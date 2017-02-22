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

  it "returns a 400 response when feedback does not exist" do
    solution = create(:solution)

    get "/api/v1/solutions/#{solution.id}/feedbacks/1"

    expect(response.status).to eq(400)
    expect(response.body).to eq("")
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

describe 'GET /api/v1/users/:user_id/solutions/:solution_id/feedbacks' do
  it 'returns all unread feedbacks' do
    user = create(:user)
    exercise = create(:exercise)
    solution1 = create(:solution, user_id: user.id)
    feedback1 = create(:feedback, solution_id: solution1.id, status: "unread")
    feedback2 = create(:feedback, solution_id: solution1.id, status: "unread")
    
    get "/api/v1/users/#{user.id}/solutions/#{solution1.id}/feedbacks"
    
    solution_json = JSON.parse(response.body)
    
    expect(response).to be_success

    expect(solution_json).to be_a(Array)

    expect(solution_json[0]).to have_key("id")
    expect(solution_json[0]).to have_key("exercise_id")
    expect(solution_json[0]).to have_key("feedbacks")
    expect(solution_json[0]["feedbacks"].count).to eq(2)
  end

  it 'returns no feedbacks if there are no feedbacks' do
    user = create(:user)
    exercise = create(:exercise)
    solution1 = create(:solution, user_id: user.id)
    
    get "/api/v1/users/#{user.id}/solutions/#{solution1.id}/feedbacks"
    
    solution_json = JSON.parse(response.body)
    
    expect(response).to be_success

    expect(solution_json).to be_a(Array)

    expect(solution_json[0]["feedbacks"].empty?).to be(true)
  end
end
