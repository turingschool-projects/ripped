class ExercisesController < ApplicationController

  def index
    if params["lang"] == nil
      @exercises = Exercise.all
    elsif params["lang"] == 'ruby'
      @ruby_exercises = Exercise.joins(:tags).where({ tags: {name: "ruby"} })
      respond_to do |format|
        format.html { render partial: 'ruby_exercises' }
      end
    elsif params["lang"] == 'js'
      @js_exercises = Exercise.joins(:tags).where({ tags: {name: "javascript"} })
      respond_to do |format|
        format.html { render partial: 'js_exercises' }
      end
    end
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

end
