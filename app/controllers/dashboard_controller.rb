class DashboardController < ApplicationController
  authorize_resource class: false

  def show
    @presenter = DashboardPresenter.new(current_user)
  end
  
end
