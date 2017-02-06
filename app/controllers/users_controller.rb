class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @in_progress = @user.solutions.where(status: "Submitted")
    @completed = @user.solutions.where(status: "Solved")
  end
end
