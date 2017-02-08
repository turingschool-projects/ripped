class ExercisesController < ApplicationController

  def index
    @exercises = Exercise.all
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

  private
    attr_reader :student_notifications

  def student_notifications(current_user)
    if current_user.role == 0 && current_user.solutions
      assessed_solutions = current_user.solutions.where(status: 1)
    end
    return assessed_solutions
  end


end
