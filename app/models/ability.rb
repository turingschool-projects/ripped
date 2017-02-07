class Ability
  include CanCan::Ability

  def initialize(user)
    user || User.new
    if user.student?
      can [:index, :show], Exercise
    end
    if user.instructor?
      can [:index, :show, :new, :create, :edit, :update], Exercise
    end
  end
end
