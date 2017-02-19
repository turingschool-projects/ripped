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
    binding.pry

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
