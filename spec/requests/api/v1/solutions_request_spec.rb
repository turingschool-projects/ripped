require 'rails_helper'

describe 'GET /api/v1/exercises/:exercise_id/solutions/:id' do
  it 'returns a single solution' do
    exercise = create(:exercise)
    solution = create(:solution)

    get "/api/v1/exercises/#{exercise.id}/solutions/#{solution.id}"

    solution_json = JSON.parse(response.body)

    expect(response).to be_success
    expect(solution_json).to be_a(Hash)
    expect(solution_json).to have_key("id")
    expect(solution_json).to have_key("exercise_id")
    expect(solution_json).to have_key("content")

    expect(solution_json).to_not have_key("created_at")
    expect(solution_json).to_not have_key("updated_at")
  end

  it 'includes feedbacks for the solution' do
    exercise = create(:exercise)
    solution = create(:solution, exercise: exercise)
    feedback = create(:feedback, solution: solution)

    get "/api/v1/exercises/#{exercise.id}/solutions/#{solution.id}"

    solution_json = JSON.parse(response.body)
    feedbacks_json = solution_json["feedbacks"]
    feedback_json = feedbacks_json[0]

    expect(response).to be_success
    expect(solution_json).to be_a(Hash)
    expect(feedbacks_json).to be_an(Array)

    expect(feedback_json).to be_a(Hash)
    expect(feedback_json).to have_key("id")
    expect(feedback_json).to have_key("user_id")
    expect(feedback_json).to have_key("solution_id")
    expect(feedback_json).to have_key("comment")
    expect(feedback_json).to have_key("created_at")
    expect(feedback_json).to have_key("updated_at")
    expect(feedback_json).to have_key("status")
  end

  it "returns a 400 response when solution does not exist" do
    exercise = create(:exercise)

    get "/api/v1/exercises/#{exercise.id}/solutions/1"

    expect(response.status).to eq(400)
    expect(response.body).to eq("")
  end
end

describe 'GET /api/v1/solutions' do
  it 'returns only solutions with no feedbacks' do
    exercise = create(:exercise)
    solution1 = create(:solution)
    solution2 = create(:solution)
    feedback1 = create(:feedback, solution_id: solution2.id)
    
    get "/api/v1/solutions"

    solution_json = JSON.parse(response.body)

    expect(response).to be_success
    expect(solution_json).to be_a(Array)
    expect(solution_json[0]).to have_key("id")
    expect(solution_json[0]).to have_key("exercise_id")
    expect(solution_json[0]).to have_key("content")
    expect(solution_json[0]["exercise"]["solutions"][0]).to have_value(solution1.content)
    expect(solution_json[0]["exercise"]["solutions"][0]).to_not have_value(solution2.content)
  end

  it 'returns nothing if all solutions have feedbacks' do
    exercise = create(:exercise)
    solution1 = create(:solution)
    solution2 = create(:solution)
    feedback1 = create(:feedback, solution_id: solution1.id)
    feedback2 = create(:feedback, solution_id: solution2.id)
    
    get "/api/v1/solutions"

    solution_json = JSON.parse(response.body)

    expect(response).to be_success

    expect(solution_json).to be_a(Array)
    expect(solution_json.empty?).to be(true)
  end
end

describe 'GET /api/v1/users/:user_id/solutions' do
  it 'returns only unread feedbacks' do
    user = create(:user)
    exercise = create(:exercise)
    solution1 = create(:solution, user_id: user.id)
    solution2 = create(:solution, user_id: user.id)
    feedback1 = create(:feedback, solution_id: solution1.id)
    feedback2 = create(:feedback, solution_id: solution2.id, status: "read")
    
    get "/api/v1/users/#{user.id}/solutions"

    solution_json = JSON.parse(response.body)

    expect(response).to be_success
    expect(solution_json).to be_a(Array)

    expect(solution_json[0]).to have_key("id")
    expect(solution_json[0]).to have_key("exercise_id")
    expect(solution_json[0]).to have_key("content")
    expect(solution_json[0]["exercise"]["solutions"][0]).to have_value(solution1.content)
    expect(solution_json[0]["exercise"]["solutions"][0]).to_not have_value(solution2.content)
  end

  it 'returns nothing if all feedbacks are read' do
    user = create(:user)
    exercise = create(:exercise)
    solution1 = create(:solution, user_id: user.id)
    solution2 = create(:solution, user_id: user.id)
    feedback1 = create(:feedback, solution_id: solution1.id, status: "read")
    feedback2 = create(:feedback, solution_id: solution2.id, status: "read")
    
    get "/api/v1/users/#{user.id}/solutions"

    solution_json = JSON.parse(response.body)

    expect(response).to be_success
    expect(solution_json).to be_a(Array)

    expect(solution_json.empty?).to be(true)
  end
end