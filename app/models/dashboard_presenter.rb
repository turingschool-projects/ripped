class DashboardPresenter
  attr_reader :solutions, :in_progress, :completed

  def initialize(user)
    @solutions = user.solutions.all
    @in_progress = @solutions.where(status: "Submitted")
    @completed = @solutions.where(status: "Solved")
  end
end
