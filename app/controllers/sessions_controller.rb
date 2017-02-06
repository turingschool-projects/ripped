class SessionsController < ApplicationController

  def create
    user = User.find_by(census_id: user_credentials.uid)
    if User.exists?(census_id: user_credentials.uid)
        session[:user_id] = user.id
      redirect_to exercises_path
    else
      user = User.create!(census_id: user_credentials.uid)
      session[:user_id] = user.id
      redirect_to exercises_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end


  private
    attr_reader :user_credentials

  def user_credentials
    env["omniauth.auth"]
  end
end
