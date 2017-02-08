class Ability
  include CanCan::Ability

  def initialize(user)
    user || User.new
    if user.student?
      can [:index, :show], Exercise
      can :show, :dashboard
      can [:new, :create, :edit, :update, :destroy], Feedback, user_id: user.id
      can [:new, :create], Solution
      can [:index, :show], Solution, exercise: {solutions: {user_id: user.id}}
    end
    if user.instructor?
      can [:index, :show, :new, :create, :edit, :update, :destroy], Exercise
      can :show, :dashboard
      can [:new, :create, :edit, :update, :destroy], Feedback
      can [:index, :show, :new, :create], Solution
    end
  end
end
