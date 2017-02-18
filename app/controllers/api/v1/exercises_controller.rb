class Api::V1::ExercisesController < ApiController
  def show
    @exercise = Exercise.find(params[:id])
    render json: @exercise, :include => [:solutions], response: 200
  end
end
