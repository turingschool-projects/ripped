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

  def edit
    @feedback = Feedback.find(params[:id])
    @solution = Solution.find(params[:solution_id])
  end

  def update
    @solution = Solution.find(params[:solution_id])
    @feedback = Feedback.find(params[:id])
    if @feedback.update(feedback_params)
      flash[:success] = "Your feedback has been updated."
      redirect_to exercise_solution_path(@solution.exercise, @solution)
    else
      render :edit
      flash.now[:danger] = "Your feedback has not been updated, please try again."
    end
  end

  def destroy
    @feedback = Feedback.find(params[:id])
    @solution = Solution.find(params[:solution_id])
    @feedback.delete
    redirect_to exercise_solution_path(@solution.exercise, @solution)
    flash[:success] = "Your feedback has been deleted."
  end

  private
    def feedback_params
      params.require(:feedback).permit(:comment, :user_id, :solution_id)
    end

end
