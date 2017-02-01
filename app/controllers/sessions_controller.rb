class SessionsController < ApplicationController
  def create
    census_user_info = env["omniauth.auth"]
  end
end
