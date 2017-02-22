class Api::V1::SolutionsController < ApiController
  def show
    @solution = Solution.find_by(id: params[:id])
    if !@solution.nil?
      render json: @solution, :include => [:feedbacks], status: 200
    else
      render body: nil, status: 400
    end
  end
end
