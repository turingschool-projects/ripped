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
end
