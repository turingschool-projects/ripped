class SolutionsPresenter
  attr_reader :solution, :user, :feedbacks, :exercise

  def initialize(id)
    @solution = Solution.find(id)
    @exercise = @solution.exercise
    @user = @solution.user
    @feedbacks = @solution.feedbacks.all
  end
end
