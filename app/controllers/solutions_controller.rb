class SolutionsController < ApplicationController

  def show
  end

  def new
    @solution = Solution.new
  end

end
