class Api::V1::SolutionsController < ApiController
  def show
    @solution = Solution.find_by(id: params[:id])
    if !@solution.nil?
      render json: @solution, status: 200
    else
      render body: nil, status: 400
    end
  end
  
  def index
    solutions = Solution.where(user_id: params[:user_id])
    @unreads = find_solutions_for_unread_feedbacks(solutions)
    if !@unreads.nil?
      render json: @unreads, status: 200
    else
      render body: nil, status: 400
    end
  end
  
  private
  
  def find_only_unread_feedbacks(solutions)
    solutions_with_unread_feedbacks = []
    solutions.each do |solution|
      if !solution.feedbacks.where(status: "unread")[0].nil?
        solutions_with_unread_feedbacks << solution.feedbacks.where(status: "unread")[0].solution_id
      end
      solutions_with_unread_feedbacks.uniq
    end
    solutions_with_unread_feedbacks
  end
  
  def find_solutions_for_unread_feedbacks(solutions)
    solutions_to_display = find_only_unread_feedbacks(solutions)
    if !solutions_to_display.nil?
      notifications = solutions_to_display.each do |solution|
        Solution.where(id: solution)
      end
    solutions
    end
    solutions
  end
end
