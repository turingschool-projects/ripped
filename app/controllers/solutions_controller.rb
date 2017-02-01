class SolutionsController < ApplicationController

  def show
  end

  def new
    @solution = Solution.new
  end

  def create
    @solution = Solution.new(solution_params)
    if @solution.save
      flash[:success] = "You have successfully submitted your solution."
      redirect_to solution_path(@solution)
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
