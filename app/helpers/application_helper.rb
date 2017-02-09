module ApplicationHelper
  def user_info(user)
    Profile.find_user(current_user.token, user.census_id)
  end
end
