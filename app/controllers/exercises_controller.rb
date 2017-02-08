class ExercisesController < ApplicationController
  load_and_authorize_resource only: [:index, :show, :new, :create, :edit, :update, :destroy]

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

  def edit
    @exercise = Exercise.find(params[:id])
  end

  def update
    @exercise = Exercise.find(params[:id])
    if @exercise.update(exercise_params)
      flash[:success] = "You have successfully updated this exercise."
      redirect_to exercise_path(@exercise)
    else
      flash[:alert] = "There was a problem updating your exercise. Please try again."
      render :edit
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy
    flash[:alert] = "#{@exercise.name} has been deleted."
    redirect_to exercises_path
  end

  private
  attr_reader :student_notifications

  def exercise_params
    params.require(:exercise).permit(:id, :name, :description, :content, :tag_ids => [])
  end

  def student_notifications(current_user)
      if current_user.role == 0 && current_user.solutions
        assessed_solutions = current_user.solutions.where(status: 1)
      end
    assessed_solutions
  end

end
