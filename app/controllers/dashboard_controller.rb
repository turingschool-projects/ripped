class DashboardController < ApplicationController
  def show
    @user = current_user
    @in_progress = @user.solutions.where(status: "Submitted")
    @completed = @user.solutions.where(status: "Solved")
  end
end
