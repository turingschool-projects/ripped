class Api::V1::FeedbacksController < ApiController
  def index
    @feedbacks = Feedback.where(user_id: params[:user_id])
    if !@feedbacks.nil?
      render json: @feedbacks, status: 200
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
end
