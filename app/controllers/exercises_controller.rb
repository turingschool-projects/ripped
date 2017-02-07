class ExercisesController < ApplicationController

  def index
    @exercises = Exercise.all
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
      flash[:success] = "You have successfully created an exercise"
      redirect_to exercise_path(@exercise)
    else
      flash[:alert] = "There was a problem creating your exercise. Please try again."
      render :new
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:id, :name, :description, :content)
  end

end
