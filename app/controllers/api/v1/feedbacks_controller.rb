class Api::V1::FeedbacksController < ApiController
  def index
    @solutions = Solution.where(user_id: params[:user_id])
    if !@solutions.nil?
      render json: @solutions, status: 200
    else 
      render body: nil, status: 400
    end
  end
  
  def show
    @feedback = Feedback.find_by(id: params[:id])
    if !@feedback.nil?
      render json: @feedback, status: 200
    else
      render body: nil, status: 400
    end
  end

  def update
    @feedback = Feedback.find_by(id: params[:id])
    if @feedback.update(feedback_params)
      render json: @feedback, status: 200
    else
      render body: nil, status: 400
    end
  end

  private

    def feedback_params
      params.require(:feedback).permit(:status)
    end
end
