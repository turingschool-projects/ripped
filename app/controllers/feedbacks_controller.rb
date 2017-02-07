class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new()
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @solution = Solution.find(params[:solution_id])
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

  private
    def feedback_params
      params.require(:feedback).permit(:comment, :user_id, :solution_id)
    end

end
