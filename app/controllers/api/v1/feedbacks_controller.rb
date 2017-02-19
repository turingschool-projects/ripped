class Api::V1::FeedbacksController < ApiController
  def show
    @feedback = Feedback.find_by(id: params[:id])
    if !@feedback.nil?
      render json: @feedback, status: 200
    else
      render body: nil, status: 400
    end
  end
end
