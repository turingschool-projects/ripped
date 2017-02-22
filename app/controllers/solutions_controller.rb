class SolutionsController < ApplicationController
  load_and_authorize_resource only: [:index, :show, :new, :create]
  before_action :set_exercise, only: [:show, :index, :new, :create]

  def index
    @solutions = @exercise.solutions
  end

  def show
    @presenter = SolutionsPresenter.new(params[:id])
    @feedback = @presenter.solution.feedbacks.new()
  end

  def new
    @solution = Solution.new()
  end

  def create
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

  def set_exercise
    @exercise = Exercise.find(params[:exercise_id])
  end

end
