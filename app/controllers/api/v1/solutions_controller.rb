class Api::V1::SolutionsController < ApiController
  def show
    @solution = Solution.find_by(id: params[:id])
    if !@solution.nil?
      render json: @solution, :include => [:feedbacks], status: 200
    else
      render body: nil, status: 400
    end
  end
  
  def index
    @solutions = Solution.where(user_id: params[:user_id])
    if !@solutions.nil?
      render json: @solutions, each_serializer: SolutionWithUnreadFeedbackSerializer, status: 200
    else
      render body: nil, status: 400
    end
  end
  
  def uncommented 
    solutions = Solution.all
    @uncommented_solutions = []
    solutions.map do |solution|
      if solution.feedbacks.empty?
        @uncommented_solutions << solution
      end
      @uncommented_solutions
    end
    if !@uncommented_solutions.nil?
      render json: @uncommented_solutions, status: 200
    else
      render body: nil, status: 400
    end
  end  
end
