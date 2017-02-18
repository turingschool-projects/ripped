class Api::V1::SolutionsController < ApiController
  def show
    @solution = Solution.find(params[:id])
    render json: @solution, response: 200
  end
end
