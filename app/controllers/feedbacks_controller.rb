class FeedbacksController < ApplicationController
  load_and_authorize_resource only: [:new, :create, :edit, :update, :destroy]
  before_action :set_feedback, only: [:edit, :update, :destroy]
  before_action :set_solution, only: [:create, :edit, :update, :destroy]

  def new
    @feedback = Feedback.new()
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user = current_user
    @feedback.solution = @solution
    if @feedback.save
      flash[:success] = "Your comment has been created!"
      redirect_to exercise_solution_path(@solution.exercise, @solution)
    else
      flash[:danger] = "Something went wrong."
      redirect_to exercise_solution_path(@solution.exercise, @solution)
    end
  end

  def edit
    @solution = Solution.find(params[:solution_id])
  end

  def update
    if @feedback.update(feedback_params)
      flash[:success] = "Your feedback has been updated."
      redirect_to exercise_solution_path(@solution.exercise, @solution)
    else
      render :edit
      flash.now[:danger] = "Your feedback has not been updated, please try again."
    end
  end

  def destroy
    @feedback.delete
    redirect_to exercise_solution_path(@solution.exercise, @solution)
    flash[:success] = "Your feedback has been deleted."
  end

  private
    def feedback_params
      params.require(:feedback).permit(:comment, :user_id, :solution_id)
    end

    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    def set_solution
      @solution = Solution.find(params[:solution_id])
    end

end
