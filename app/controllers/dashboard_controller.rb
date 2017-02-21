class DashboardController < ApplicationController
  authorize_resource class: false

  def show
    @user = current_user
    @solutions = @user.solutions.all
    @in_progress = @user.solutions.where(status: "Submitted")
    @completed = @user.solutions.where(status: "Solved")
    @submitted = Solution.where(status: "Submitted")
  end
  
end
