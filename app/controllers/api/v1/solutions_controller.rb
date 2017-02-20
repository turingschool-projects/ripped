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
    @solutions = Solution.where(user_id: params[:user_id])
    if !@solutions.nil?
      render json: @solutions, status: 200
    else
      render body: nil, status: 400
    end
  end
end
