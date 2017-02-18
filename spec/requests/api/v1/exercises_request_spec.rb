require 'rails_helper'

describe 'GET /api/v1/exercises/:id' do
  it 'returns a single exercise' do
    exercise = create(:exercise)

    get "/api/v1/exercises/#{exercise.id}"

    exercise_json = JSON.parse(response.body)

    expect(response).to be_success
    expect(exercise_json).to be_a(Hash)
    expect(exercise_json).to have_key("id")
    expect(exercise_json).to have_key("content")
    expect(exercise_json).to have_key("name")
    expect(exercise_json).to have_key("solutions")
  end

  it 'includes solutions to the exercise' do
    exercise = create(:exercise)
    solution = create(:solution, exercise: exercise)

    get "/api/v1/exercises/#{exercise.id}"

    exercise_json = JSON.parse(response.body)

    expect(response).to be_success
    expect(exercise_json).to be_a(Hash)
    expect(exercise_json["solutions"]).to be_an(Array)
  end
end
