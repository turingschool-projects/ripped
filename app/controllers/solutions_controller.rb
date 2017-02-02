class SolutionsController < ApplicationController

  def show
    @solution = Solution.find(params[:id])
  end

  def new
    @exercise = Exercise.find(params[:exercise_id])
    @solution = Solution.new()
  end

  def create
    @exercise = Exercise.find(params[:exercise_id])
    @solution = Solution.new(solution_params)
    @solution.exercise = @exercise
    if @solution.save
      flash[:success] = "You have successfully submitted your solution."
      redirect_to exercise_solution_path(@exercise, @solution)
    else
      flash[:alert] = "Your solution did not save."
      render :new
    end
  end

  private

  def solution_params
    params.require(:solution).permit(:id, :content, :user_id, :exercise_id)
  end

end
