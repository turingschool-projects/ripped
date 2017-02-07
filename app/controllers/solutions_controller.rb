class SolutionsController < ApplicationController

  def show
    @solution = Solution.find(params[:id])
    @exercise = @solution.exercise
    @feedbacks = @solution.feedbacks.all
    @feedback = @solution.feedbacks.new()
  end

  def new
    @exercise = Exercise.find(params[:exercise_id])
    @solution = Solution.new()
  end

  def create
    @exercise = Exercise.find(params[:exercise_id])
    @solution = Solution.new(solution_params)
    @solution.exercise = @exercise
    @solution.user = current_user
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
