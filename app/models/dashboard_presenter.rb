class DashboardPresenter
  attr_reader :solutions, :in_progress, :completed

  def initialize(user)
    @solutions = user.solutions.all
    @in_progress = user.solutions.where(status: "Submitted")
    @completed = user.solutions.where(status: "Solved")
  end
end
