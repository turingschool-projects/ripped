class DashboardController < ApplicationController
  authorize_resource class: false

  def show
    if current_user.student?
      @presenter = DashboardPresenter.new(current_user)
    elsif current_user.instructor?
      @instructor_presenter = InstructorDashboardPresenter.new(current_user)
    end
  end
  
end
