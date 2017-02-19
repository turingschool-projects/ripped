class ExercisesController < ApplicationController
  authorize_resource only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @exercises = Exercise.where(status: 0)
    @ruby_exercises = Exercise.joins(:tags).where({ tags: {name: "ruby"} })
    @js_exercises = Exercise.joins(:tags).where({ tags: {name: "javascript"}})
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

  def new
    @exercise = Exercise.new
  end

  def create
    e_params = exercise_params
    tag_ids = e_params.delete(:tag_names).delete_if(&:empty?)
    @exercise = Exercise.new(e_params)
    @exercise.tag_names = tag_ids

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
    e_params = exercise_params
    tag_ids = e_params.delete(:tag_names).delete_if(&:empty?)
    @exercise = Exercise.find(params[:id])
    @exercise.tag_names = tag_ids

    if @exercise.update(e_params)
      flash[:success] = "You have successfully updated this exercise."
      redirect_to exercise_path(@exercise)
    else
      flash[:alert] = "There was a problem updating your exercise. Please try again."
      render :edit
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    if @exercise.published?
      @exercise.update(status: 1)
      flash[:alert] = "#{@exercise.name} has been unpublished."
      redirect_to exercises_path
    else
      @exercise.update(status: 0)
      flash[:alert] = "#{@exercise.name} has been published."
      redirect_to exercise_path(@exercise)
    end
  end

  private
  attr_reader :student_notifications

  def exercise_params
    params.require(:exercise).permit(:id, :name, :description, :content, :tag_names => [])
  end

  def student_notifications(current_user)
      if current_user.role == 0 && current_user.solutions
        assessed_solutions = current_user.solutions.where(status: 1)
      end
    assessed_solutions
  end

end
