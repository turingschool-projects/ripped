class InstructorDashboardPresenter
  attr_reader :submitted, :solved

  def initialize(user)
    @submitted = Solution.where(status: "Submitted")
    @solved = Solution.where(status: "Solved")
  end
  
end
