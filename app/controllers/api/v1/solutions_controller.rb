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
    @unreads = find_only_unread_feedbacks(solutions)
    if !@unreads.nil?
      render json: @unreads, status: 200
    else
      render body: nil, status: 400
    end
  end
  
  private
  
  def find_only_unread_feedbacks(solutions)
    solutions_with_unread_feedbacks = solutions.map do |solution|
      solution.feedbacks.where(status: "unread")
    end
    solutions_with_unread_feedbacks
  end
end
