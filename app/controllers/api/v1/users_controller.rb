class Api::V1::UsersController < ApiController
  def show
    @user = User.find_by(id: params[:id])
    if !@user.nil?
      render json: @user, status: 200
    else
      render body: nil, status: 400
    end
  end
end
