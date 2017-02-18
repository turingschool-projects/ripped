class Api::V1::ExercisesController < ApiController
  def index
    @exercises = Exercise.all
    render json: @exercises, :include => [:solutions], status: 200
  end

  def show
    @exercise = Exercise.find_by(id: params[:id])
    if !@exercise.nil?
      render json: @exercise, :include => [:solutions], status: 200
    else
      render body: nil, status: 400
    end
  end
end
