class ExercisesController < ApplicationController

  def index
    @exercises = Exercise.all
    @js_exercises = Exercise.joins(:tags).where("tag_id = 1")
    @ruby_exercises = Exercise.joins(:tags).where("tag_id = 2")
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

end
