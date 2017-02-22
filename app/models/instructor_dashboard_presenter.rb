class InstructorDashboardPresenter
  attr_reader :submitted

  def initialize(user)
    @submitted = Solution.where(status: "Submitted")
  end
  
end
