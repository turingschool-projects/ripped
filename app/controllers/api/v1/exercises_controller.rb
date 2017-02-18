class Api::V1::ExercisesController < ApiController
  def index
    @exercises = Exercise.all
    render json: @exercises, :include => [:solutions], response: 200
  end

  def show
    @exercise = Exercise.find(params[:id])
    render json: @exercise, :include => [:solutions], response: 200
  end
end
