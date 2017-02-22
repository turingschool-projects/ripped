class InstructorDashboardPresenter
  attr_reader :submitted, :solved, :cohorts

  def initialize(user)
    @submitted = Solution.where(status: "Submitted")
    @solved = Solution.where(status: "Solved")
    @cohorts = all_cohorts(user)
  end


  def all_cohorts(user)
    cohorts = []
    Solution.all.each do |solution|
      cohorts << solution.user.census_cohort(user.token)
    end
    return cohorts.uniq
  end

end
