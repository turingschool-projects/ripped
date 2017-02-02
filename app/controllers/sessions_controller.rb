class SessionsController < ApplicationController

  def create
    census_user_info = env["omniauth.auth"]
    byebug
    redirect_to root_path
  end
end
